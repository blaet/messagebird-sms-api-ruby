require 'rubygems'
require 'bundler'

# Use SimpleCov when available
begin
  require 'simplecov'
  SimpleCov.start
rescue LoadError
end

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'minitest/autorun'
require 'rr'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'message_bird'

class MiniTest::Unit::TestCase
end

MiniTest.autorun
