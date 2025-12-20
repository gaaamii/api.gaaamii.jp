source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.0'

gem 'rails', '~> 8.0.2'
gem 'pg'
gem 'puma'
gem 'bootsnap'
gem 'sorcery'
gem 'rack-cors'
gem 'cloudinary'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem "factory_bot_rails"
end

group :development do
  gem 'listen', '~> 3.8'
end

group :test do
  gem 'rspec-rails'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
