FactoryBot.define do
  factory :introduction do
    sequence(:content) { |n| "test content #{n}" }
  end
end
