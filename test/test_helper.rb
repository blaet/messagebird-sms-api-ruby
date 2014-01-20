require 'rubygems'

gem "minitest"
require 'minitest/autorun'
require 'ostruct'
# require 'rr'

# Small hack to enable require_relative
unless Kernel.respond_to?(:require_relative)
  module Kernel
    def require_relative(path)
      require File.join(File.dirname(caller[0]), path.to_str)
    end
  end
end
