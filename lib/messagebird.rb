$LOAD_PATH.unshift File.dirname(__FILE__)

require 'messagebird/config'
require 'pp'
require 'net/http'
require "net/https"
require "uri"

module MessageBird
  class << self

    def send_text_message(phone_numbers, message)
      url = create_url(phone_numbers, message)
      uri = create_uri(url)

      connection = create_connection(uri)

      request = Net::HTTP::Get.new(uri.request_uri)
      response = connection.request(request)
      pp response.body
    end

    def configure(&block)
      MessageBird::Config.configure(&block)
    end

protected

    def create_connection(uri)
      Net::HTTP.new(uri.host, uri.port).tap do |http|
        http.use_ssl = true
        # http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
    end

    def create_uri(url)
      URI.parse(url)
    end

    def create_url(phone_numbers, message)
      username    = MessageBird::Config.username
      password    = URI.escape(MessageBird::Config.password)
      api_url     = MessageBird::Config.api_url
      sender      = MessageBird::Config.sender_name
      test_mode   = MessageBird::Config.fetch(:test_mode, true) ? 1 : 0 # If test = 1, then the message is not actually sent or scheduled, and there will be no credits deducted

      destination = format_phone_numbers(phone_numbers)
      message     = URI.escape(message)

      "#{api_url}?username=#{username}&password=#{password}&sender=#{sender}&test=#{test_mode}&destination=#{destination}&body=#{message}"
    end

    def format_phone_numbers(phone_numbers)
      # API accepts multiple phone numbers by seperating them with a comma ','
      if phone_numbers.is_a? Enumerable
        phone_numbers.join(',')
      else
        "#{phone_numbers}"
      end
    end

  end
end
