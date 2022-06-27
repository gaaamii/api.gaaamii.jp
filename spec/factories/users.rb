FactoryBot.define do
  factory :user do
    email { ENV['ADMIN_USER_EMAIL'] }
    password { 'test_password' }
  end
end
