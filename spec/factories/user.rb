FactoryBot.define do
    factory :user do
        email { "ralph@example.com" }
        password { "test@123" }
        association :organization, factory: :organization
    end
end
  