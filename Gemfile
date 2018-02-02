source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end



gem 'rails', '~> 5.1.4'
gem 'puma', '~> 3.7'
gem 'devise'
gem 'active_model_serializers', '~> 0.10.0'
gem 'kaminari'
gem 'doorkeeper'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.6.1'
  gem 'factory_girl_rails', '4.8.0'
  gem 'shoulda-matchers', '~> 3.1.2'
  gem 'faker', :git => 'https://github.com/stympy/faker.git', :branch => 'master'
end

group :development do
  gem 'sqlite3'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
