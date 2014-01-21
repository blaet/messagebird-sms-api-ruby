$LOAD_PATH.unshift File.dirname(__FILE__)

require 'messagebird/config'
require 'pp'
require 'net/http'
require "net/https"
require "uri"

module MessageBird
  class << self

    def send_text_message(destination, message)
      load_variables

      connection(destination, message)




      # request_url =
      # uri = URI.parse(request_url)
      # full_path = (uri.query == "")  ? uri.path : "#{uri.path}?#{uri.query}"
      # pp full_path

      # connection = Net::HTTP.new(uri.host, uri.port)
      # connection.use_ssl = true
      # the_request = connection.get(full_path)

      # # the_request = Net::HTTP::Get.new(full_path)
      # the_response = connection.start{ |http| http.request(the_request) }

      # pp 'Request URL:'
      # pp request_url
      # pp uri
      # pp 'Full path:'
      # pp full_path
      # pp 'Request'
      # pp the_request
      # pp 'Response'
      # pp the_response

      # pp 'Body'
      # pp(the_response.body)



      # destination = "31600000000" # more number can be added by seperating them with a comma (,)
      # request_uri = api_uri + "?" + "username=" + username + "&password=" + password +
      #         "&body=" + message + "&sender=" + sender_name + "&destination=" + destination + "&test=" + test
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

    def connection(destination, message)
      uri = URI.parse(request_url(destination, message))
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      pp response.body

      # http = Net::HTTP.new(uri.host, uri.port)
      # http.use_ssl = true
      # # http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      # pp request = Net::HTTP::Get.new(uri.request_uri)

      # pp response = http.request(request)
      # pp response.body
      # pp response.status

    end

    def request_url(destination, message)
      message   = URI.escape(message)
      @password = URI.escape(@password)
      "#{@api_url}?username=#{@username}&password=#{@password}&sender=#{@sender}&test=#{@test_mode}&destination=#{destination}&body=#{message}"
    end
  end
end
