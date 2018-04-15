class SearchTask < ApplicationRecord
  validates :name, presence: true, uniqueness: { allow_blank: true }

  has_one_attached :keywords_csv
end
