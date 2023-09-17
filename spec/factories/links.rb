FactoryBot.define do
  factory :link do
    sequence(:name) { |n| "test name #{n}" }
    sequence(:url) { |n| "https://www.example.com/#{n}" }
  end
end
