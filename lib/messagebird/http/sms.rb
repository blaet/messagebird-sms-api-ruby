module MessageBird::HTTP
  class SMS < MessageBird::Deliverable
    include MessageBird::Helpers

    attr_reader :originator, :recipients, :message
    attr_writer :username, :api_url

    def initialize(originator, recipients, message, options = {}, &block)
      @originator = originator
      @recipients = format_recipients(recipients)
      @message    = URI.escape(message)
      @callback   = block

      set_optional_variables(options)
    end

    def deliver
      Sender.deliver(self, &@callback)
    end

    def uri
      @uri ||= URI.parse(url)
    end

    def request_uri
      uri.request_uri
    end

    def url
      @url ||= "#{api_url}?username=#{username}&password=#{password}&sender=#{originator}&test=#{test_mode}&destination=#{recipients}&body=#{message}"
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
        send("#{k}=".to_sym, v)
      end
    end

    def password=(str)
      @password = escape(str)
    end

    def test_mode=(bool)
      raise ArgumentError unless !!bool == bool
      @test_mode = bool ? 1 : 0
    end

  end
end
