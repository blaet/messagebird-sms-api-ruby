# encoding: utf-8

require 'rubygems'
require 'bundler'

# Bundler setup
begin
  Bundler.setup(:default, :test, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

# Optional Jeweler setup
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "messagebird"
    gem.homepage = "http://github.com/blaet/messagebird-sms-api-ruby"
    gem.license = "MIT"
    gem.summary = %Q{MessageBird API for Ruby}
    gem.description = %Q{Implementation of the MessageBird SMS API for Ruby}
    gem.email = "dev@blaet.net"
    gem.authors = ["Bram de Vries"]
    # dependencies defined in Gemfile
  end
  Jeweler::RubygemsDotOrgTasks.new
rescue LoadError
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

task :default => :test
