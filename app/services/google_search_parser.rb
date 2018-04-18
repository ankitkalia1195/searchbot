class GoogleSearchParser
  AD_URL_PREFIX = 'https://www.googleadservices.com/pagead'
  GOOGLE_SEARCH_URL = 'http://www.google.com/search?q='

  attr_accessor :html_source, :parsed_html

  def initialize(keyword)
    url = GOOGLE_SEARCH_URL + keyword
    self.html_source = open(url, &:read)
    self.parsed_html = Nokogiri::HTML html_source
  end

  def top_ad_urls
    @top_ad_urls ||= parsed_html.css('#KsHht .ads-ad').map {|element| ad_result_url_value(element) }.compact
  end

  def bottom_ad_urls
    @bottom_ad_urls ||= parsed_html.css('#D7Sjmd .ads-ad').map {|element| ad_result_url_value(element)  }.compact
  end

  def regular_result_urls
    @search_result_urls ||= parsed_html.css('h3.r').map {|element| regular_result_url_vaue(element)  }.compact
  end

  def results_count
    @results_count ||= parsed_html.css('#resultStats').first.try(:text)
  end

  def all_links_count
    @all_links_count ||= parsed_html.css('a').count
  end

  private

  def ad_result_url_value(element)
    value = element.css('a').first.try(:[], :href)
    value.present? ? (AD_URL_PREFIX + value) : nil
  end

  def regular_result_url_vaue(element)
    value = element.css('a').first.try(:[], :href)
    value.present? ? value.gsub('/url?q=', '') : nil
  end

end
