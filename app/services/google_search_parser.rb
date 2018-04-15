class GoogleSearchParser
  attr_accessor :html_source, :parsed_html
  AD_URL_PREFIX = 'https://www.googleadservices.com/pagead'
  GOOGLE_SEARCH_URL = 'http://www.google.com/search?q='

  def initialize(keyword)
    url = GOOGLE_SEARCH_URL + keyword
    self.html_source = open(url, &:read)
    self.parsed_html = Nokogiri::HTML html_source
  end

  def top_ad_urls
    @top_ad_urls ||= parsed_html.css('#KsHht .ads-ad').map {|element| AD_URL_PREFIX + element.css('a').first.try(:[], :href) }.compact
  end

  def bottom_ad_urls
    @bottom_ad_urls ||= parsed_html.css('#D7Sjmd .ads-ad').map {|element| AD_URL_PREFIX + element.css('a').first.try(:[], :href) }.compact
  end

  def regular_result_urls
    @search_result_urls ||= parsed_html.css('h3.r').map {|element| element.css('a').first.try(:[], :href) }.compact
  end

  def results_count
    @results_count ||= parsed_html.css('#resultStats').first.try(:text)
  end

end
