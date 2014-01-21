module MessageBird::HTTP
  class SMS < MessageBird::Deliverable

    attr_writer :username, :api_url

    def initialize(originator, recipients, message, options = {})
      @originator = originator
      @recipients = format_recipients(recipients)
      @message    = URI.escape(message)

      set_optional_variables(options)
    end

    def deliver
      url = create_url(phone_numbers, message)
      uri = create_uri(url)

      connection = create_connection(uri)

      request = Net::HTTP::Get.new(uri.request_uri)
      response = connection.request(request)
      pp response.body
    end

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

      destination = format_phone_numbers(phone_numbers)
      message     = URI.escape(message)

      "#{api_url}?username=#{username}&password=#{password}&sender=#{sender}&test=#{test_mode}&destination=#{destination}&body=#{message}"
    end

    def username
      @username ||= escape MessageBird::Config.username
    end

    def password
      @password ||= escape MessageBird::Config.password
    end

    def test_mode
      # If test = 1, then the message is not actually sent or scheduled, and there will be no credits deducted
      @test_mode ||= MessageBird::Config.fetch(:test_mode, true) ? 1 : 0
    end

    def api_url
      @api_url ||= MessageBird::Config.api_url
    end

  private

    def format_recipients(recipients)
      # API accepts multiple phone numbers by seperating them with a comma ','
      if recipients.is_a? Enumerable
        recipients.join(',')
      else
        "#{recipients}"
      end
    end

    def set_optional_variables(options = {})
      options.each do |k,v|
        send(k.to_sym, v)
      end
    end

    def password=(str)
      @password = escape(str)
    end

    def test_mode=(bool)
      raise ArgumentError unless bool.is_a?(Boolean)
      @test_mode = bool ? 1 : 0
    end

  end
end
