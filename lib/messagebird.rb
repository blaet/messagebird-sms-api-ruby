$LOAD_PATH.unshift File.dirname(__FILE__)

require 'messagebird/config'
require 'pp'
require 'net/http'
require "net/https"
require "uri"

module MessageBird
  class << self

    def send_text_message(phone_numbers, message)
      load_variables

      connection(phone_numbers, message)
    end

    def configure(&block)
      MessageBird::Config.configure(&block)
    end

  private

    def load_variables
      @username   = MessageBird::Config.username
      @password   = MessageBird::Config.password
      @api_url    = MessageBird::Config.api_url
      @sender     = MessageBird::Config.sender_name
      @test_mode  = MessageBird::Config.fetch(:test_mode, true) ? 1 : 0 # If test = 1, then the message is not actually sent or scheduled, and there will be no credits deducted
    end

    def connection(phone_numbers, message)
      uri = URI.parse(request_url(phone_numbers, message))
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      # http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      pp response.body
    end

    def request_url(phone_numbers, message)
      destination = format_phone_numbers(phone_numbers)
      message   = URI.escape(message)
      @password = URI.escape(@password)
      "#{@api_url}?username=#{@username}&password=#{@password}&sender=#{@sender}&test=#{@test_mode}&destination=#{destination}&body=#{message}"
    end

    def format_phone_numbers(phone_numbers)
      if phone_numbers.is_a? Enumerable
        # API accepts multiple phone numbers by seperating them with a comma ','
        phone_numbers.join(',')
      else
        "#{phone_numbers}"
      end
    end
  end
end
