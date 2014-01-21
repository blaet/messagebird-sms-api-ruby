$LOAD_PATH.unshift File.dirname(__FILE__)

require 'messagebird/config'
require 'messagebird/deliverable'
require 'messagebird/helpers'
require 'messagebird/sms'
require 'messagebird/http/sms'
require 'messagebird/http/request_url'

require 'net/http'
require 'net/https'
require 'uri'

require 'pp'

module MessageBird
  class << self

    def deliver(originator, recipients, message, options={})
      MessageBird::SMS.deliver(originator, recipients, message, options)
    end

    def configure(&block)
      MessageBird::Config.configure(&block)
    end

  end
end
