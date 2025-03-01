FactoryBot.define do
  factory :room do
    name { "MyString" }
    is_private { false }
    assignee { create(:user, :internal) }
    organization
  end
end
