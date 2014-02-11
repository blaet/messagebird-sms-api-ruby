module MessageBird::HTTP
  class Sender
    class << self

      attr_writer :response_factory
      attr_writer :local_loop

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
        connection_factory.call(uri.host, uri.port).tap do |http|
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

      def connection_factory
        @connection_factory ||= connection_class.public_method(:new)
      end

      def response_factory
        @response_factory ||= Response.public_method(:new)
      end

      def local_loop
        if @local_loop.nil?
          @local_loop = MessageBird::Config.local_loop
        end
        @local_loop
      end

      def connection_class
        if local_loop
          LocalConnection
        else
          Net::HTTP
        end
      end

    end
  end
end
