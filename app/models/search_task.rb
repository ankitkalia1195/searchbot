class SearchTask < ApplicationRecord
  has_many :search_reports, dependent: :destroy
  has_one_attached :keywords_csv

  after_create :enqueue_processing

  validates :name, presence: true, uniqueness: { allow_blank: true }

  state_machine :state, initial: :pending do
    event :process do
      transition to: :processing, from: [:pending, :failure]
    end

    event :complete do
      transition to: :complete, from: :processing
    end

    after_transition to: :processing, do: :create_search_reports!
  end

  private

  def create_search_reports!
    keywords = CSV.parse(keywords_csv.download).flatten.map(&:strip).uniq.select(&:present?)
    search_reports.destroy_all
    keywords.each { |keyword| search_reports.create!(keyword: keyword).process! }
    complete!
  end

  def enqueue_processing
    ProcessSearchTaskJob.perform_later(self)
  end
end
