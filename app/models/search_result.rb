class SearchResult < ApplicationRecord
  enum result_type: [:regular, :top_ad, :bottom_ad]

  belongs_to :search_report
  validates :url, :result_type, presence: true

  delegate :keyword, :search_task, to: :search_report

  def ad?
    top_ad? || bottom_ad?
  end
end
