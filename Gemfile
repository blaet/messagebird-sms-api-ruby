source 'https://rubygems.org'

group :test do
  gem 'bundler',  '~> 1.0'
  gem 'rake'
  gem 'minitest', :require => false
  gem 'rr',       :require => false
end

platform :ruby_19, :ruby_20, :ruby_21 do
  group :test do
    gem 'coveralls', :require => false
  end

  group :development do
    gem 'jeweler', '~> 2.0.0', :require => false
  end
end

