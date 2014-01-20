# require 'rubygems'

# gem "minitest"
# require 'minitest/autorun'
# require 'ostruct'
# # require 'rr'

# # Small hack to enable require_relative
# unless Kernel.respond_to?(:require_relative)
#   module Kernel
#     def require_relative(path)
#       require File.join(File.dirname(caller[0]), path.to_str)
#     end
#   end
# end

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'minitest/autorun'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'message_bird'

class MiniTest::Unit::TestCase
end

MiniTest.autorun
