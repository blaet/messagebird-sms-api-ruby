$LOAD_PATH.unshift File.dirname(__FILE__)

require 'net/http'
require 'net/https'
require 'uri'

require 'messagebird/config'
require 'messagebird/deliverable'
require 'messagebird/helpers'
require 'messagebird/sms'
require 'messagebird/http/local_connection'
require 'messagebird/http/sender'
require 'messagebird/http/sms'
require 'messagebird/http/response_code'
require 'messagebird/http/response'

module MessageBird
  class << self

    def deliver(originator, recipients, message, options={}, &block)
      MessageBird::SMS.deliver(originator, recipients, message, options, &block)
    end

    def configure(&block)
      MessageBird::Config.configure(&block)
    end

  end
end
