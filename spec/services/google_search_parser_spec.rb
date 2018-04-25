require 'rails_helper'

describe GoogleSearchParser do
  let(:google_search_parser) { GoogleSearchParser.new('new york tours') }
  let(:html_source) { File.read(Rails.root.join('spec', 'fixtures', 'files', 'google_search_results.html')).gsub(/[\\\"]/,"") }

  before { allow_any_instance_of(GoogleSearchParser).to receive(:open).and_return(html_source) }

  it { expect(google_search_parser.top_ad_urls).to eq(["https://www.googleadservices.com/pagead/aclk?sa=l&ai=DChcSEwjtoKGPvsbaAhXLNSsKHYz7COMYABAAGgJzZg&sig=AOD64_1bfrQOENboBqjWfXsh1blnLBaUCw&ved=0ahUKEwjt_JyPvsbaAhXEuI8KHaTuBi0Q0QwIEQ&adurl=",
                                                       "https://www.googleadservices.com/pagead/aclk?sa=l&ai=DChcSEwjtoKGPvsbaAhXLNSsKHYz7COMYABABGgJzZg&sig=AOD64_3hyDHYv1mNOGs6sBsfUR17Web47w&ved=0ahUKEwjt_JyPvsbaAhXEuI8KHaTuBi0Q0QwIFg&adurl=",
                                                       "https://www.googleadservices.com/pagead/aclk?sa=l&ai=DChcSEwjtoKGPvsbaAhXLNSsKHYz7COMYABACGgJzZg&sig=AOD64_1yvzKVkGket_wtwS_mrZli1DcIUw&ved=0ahUKEwjt_JyPvsbaAhXEuI8KHaTuBi0Q0QwIHg&adurl=",
                                                       "https://www.googleadservices.com/pagead/aclk?sa=l&ai=DChcSEwjtoKGPvsbaAhXLNSsKHYz7COMYABADGgJzZg&sig=AOD64_2Da0uFFRsL49uyHP-0aXWdyd1jTA&ved=0ahUKEwjt_JyPvsbaAhXEuI8KHaTuBi0Q0QwIJA&adurl="]) }
  it { expect(google_search_parser.bottom_ad_urls).to eq(["https://www.googleadservices.com/pagead/aclk?sa=l&ai=DChcSEwjtoKGPvsbaAhXLNSsKHYz7COMYABAEGgJzZg&sig=AOD64_3Ud-4dqgfICkEhWbFFde77urV2Zw&ved=0ahUKEwjt_JyPvsbaAhXEuI8KHaTuBi0Q0QwIfg&adurl=",
                                                          "https://www.googleadservices.com/pagead/aclk?sa=l&ai=DChcSEwjtoKGPvsbaAhXLNSsKHYz7COMYABAHGgJzZg&sig=AOD64_37jR94E_KL6LgF73zo6LDrDm7Lyw&ved=0ahUKEwjt_JyPvsbaAhXEuI8KHaTuBi0Q0QwIhgE&adurl=",
                                                          "https://www.googleadservices.com/pagead/aclk?sa=l&ai=DChcSEwjtoKGPvsbaAhXLNSsKHYz7COMYABAIGgJzZg&sig=AOD64_19aExt1EE6zQZ2GSDyEB5NmC-hLA&ved=0ahUKEwjt_JyPvsbaAhXEuI8KHaTuBi0Q0QwIjgE&adurl="]) }

  it { expect(google_search_parser.regular_result_urls).to eq(["https://www.viator.com/New-York-City/d687-ttd&sa=U&ved=0ahUKEwjt_JyPvsbaAhXEuI8KHaTuBi0QFgg1MAI&usg=AOvVaw3Nz9Xh5ypfOEDreNlhlxIc", "https://www.taketours.com/new-york-ny/&sa=U&ved=0ahUKEwjt_JyPvsbaAhXEuI8KHaTuBi0QFgg5MAM&usg=AOvVaw0YrWQAi-21bUWN6crA8Z0o", "https://www.viator.com/New-York-City/d687-ttd&sa=U&ved=0ahUKEwjt_JyPvsbaAhXEuI8KHaTuBi0QFghCMAQ&usg=AOvVaw1VGisHXXU_mfFJifQVCeEV", "https://www.tripadvisor.in/Attractions-g60763-Activities-c42-New_York_City_New_York.html&sa=U&ved=0ahUKEwjt_JyPvsbaAhXEuI8KHaTuBi0QFghMMAU&usg=AOvVaw37v0BK2R6IUKJaOnjBprVA", "https://www.newyorksightseeing.com/nyc-tours.html&sa=U&ved=0ahUKEwjt_JyPvsbaAhXEuI8KHaTuBi0QFghSMAY&usg=AOvVaw2vUsa4aKIwrceJR0GblZVr", "https://www.citysightseeingnewyork.com/nyc-packages-deals.html&sa=U&ved=0ahUKEwjt_JyPvsbaAhXEuI8KHaTuBi0QFghYMAc&usg=AOvVaw1_FfHvxT2neJ9bAI7P0Wcj", "/search?q=new+york+tours&ie=UTF-8&prmd=ivns&source=univ&tbm=nws&tbo=u&sa=X&ved=0ahUKEwjt_JyPvsbaAhXEuI8KHaTuBi0QqAIIXg", "http://www.tours4fun.com/tours/new-york/&sa=U&ved=0ahUKEwjt_JyPvsbaAhXEuI8KHaTuBi0QFghnMAs&usg=AOvVaw3xhnGEJ7vc7nFx1O15M6rw", "https://www.nycgo.com/things-to-do/tours-in-nyc&sa=U&ved=0ahUKEwjt_JyPvsbaAhXEuI8KHaTuBi0QFghtMAw&usg=AOvVaw0rkPfc3WviKenoxiO8J0G4", "https://www.nynytours.com/&sa=U&ved=0ahUKEwjt_JyPvsbaAhXEuI8KHaTuBi0QFghyMA0&usg=AOvVaw0twTiK8ZuEHVk-8XqBdyfL", "https://freetoursbyfoot.com/new-york-bus-tours/&sa=U&ved=0ahUKEwjt_JyPvsbaAhXEuI8KHaTuBi0QFgh4MA4&usg=AOvVaw18UwDEbbkYtv6myS5ntUZ5"]) }

  it { expect(google_search_parser.results_count).to eq('About 2,56,00,000 results') }
  it { expect(google_search_parser.all_links_count).to eq(109) }
end

