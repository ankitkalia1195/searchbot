FactoryBot.define do
  factory :search_task do
    user
    name 'test_name'

    after(:build) do |search_task|
      search_task.keywords_csv.attach(io: File.open(Rails.root.join('spec', 'factories', 'csv', 'keywords.csv')), filename: 'keywords.csv', content_type: 'text/csv')
    end
  end
end
