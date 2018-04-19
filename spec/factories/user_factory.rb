FactoryBot.define do

  factory :user do
    email 'test@mailinator.com'
    password '123456'

    after(:create) do |created_user|
      created_user.access_tokens.create!
    end
  end

end
