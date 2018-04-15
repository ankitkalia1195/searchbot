class SearchResult < ApplicationRecord
  enum result_type: [:regular, :top_ad, :bottom_ad]

  belongs_to :search_report
  validates :url, :result_type, presence: true
end
