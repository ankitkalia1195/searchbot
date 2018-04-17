class SearchTask < ApplicationRecord
  enum state: [:pending, :processing, :complete, :failed]

  belongs_to :user
  has_many :search_reports, dependent: :destroy
  has_many :search_results, through: :search_reports
  has_one_attached :keywords_csv

  after_create :enqueue_processing

  validates :user, :name, :state, presence: true
  validates :name, uniqueness: { scope: :user_id }

  def process!
    begin
      update_column(:state, :processing)
      parse_keywords_and_create_reports
      update_column(:state, :complete)
    rescue Exception => e
      update_column(:state, :failed)
      raise e
    end
  end

  private

  def parse_keywords_and_create_reports
    keywords = CSV.parse(keywords_csv.download).flatten.map(&:strip).uniq.select(&:present?)
    search_reports.destroy_all
    keywords.each { |keyword| search_reports.create!(keyword: keyword).process! }
  end

  def enqueue_processing
    ProcessSearchTaskJob.perform_later(self)
  end
end
