FactoryBot.define do
  factory :user do
    name { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { DateTime.current }

    trait :internal do
      user_type { 'internal' }
      after(:build) do |instance|
        create(:organization, owner: instance)
      end
    end

    trait :external do
      user_type { 'external' }
    end
  end
end
