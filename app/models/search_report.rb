class SearchReport < ApplicationRecord
  belongs_to :search_task
  has_many :search_results, dependent: :destroy

  validates :keyword, presence: true

  def process!
    parsed_google_results = GoogleSearchParser.new(keyword)
    new_search_results = []
    parsed_google_results.top_ad_urls.each { |url| new_search_results << search_results.build(url: url, result_type: 'top_ad') }
    parsed_google_results.regular_result_urls.each { |url| new_search_results << search_results.build(url: url, result_type: 'regular') }
    parsed_google_results.bottom_ad_urls.each { |url| new_search_results << search_results.build(url: url, result_type: 'bottom_ad') }
    SearchResult.import(new_search_results)
    update_columns(result_stats: { top_ad_count: parsed_google_results.top_ad_urls.size,
                      bottom_ad_count: parsed_google_results.bottom_ad_urls.size,
                      total_ad_count: parsed_google_results.top_ad_urls.size + parsed_google_results.bottom_ad_urls.size,
                      all_links_count: parsed_google_results.all_links_count,
                      regular_results_count: parsed_google_results.regular_result_urls.size,
                      results_count: parsed_google_results.results_count }, html: parsed_google_results.html_source)

  end

end
