FactoryBot.define do
  factory :organization do
    name { Faker::Company.name }
    website { Faker::Internet.domain_name }
    owner { create(:user) }
  end
end
