FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "test title #{n}" }
    sequence(:body) { |n| "test body #{n}" }
    published_at { Time.zone.now }
  end
end
