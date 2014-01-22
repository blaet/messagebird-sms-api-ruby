module MessageBird::HTTP
  class Sender
    class << self

      attr_writer :response_factory

      def deliver(sms, &block)
        ensure_valid_sms!(sms)
        send_sms(sms, &block)
      end

    private

      def send_sms(sms, &block)
        connection = create_connection(sms.uri)
        request    = create_request(sms.request_uri)

        response = send_request(connection, request)

        if block_given?
          yield response
        end
      end

      def send_request(connection, request)
        response_factory.call( connection.request(request) )
      end

      def create_connection(uri)
        Net::HTTP.new(uri.host, uri.port).tap do |http|
          http.use_ssl = true
          # http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
      end

      def create_request(request_uri)
        Net::HTTP::Get.new(request_uri)
      end

      def ensure_valid_sms!(obj)
        raise ArgumentError unless obj.is_a? MessageBird::HTTP::SMS
      end

      def response_factory
        @response_factory ||= Response.public_method(:new)
      end

    end
  end
end
