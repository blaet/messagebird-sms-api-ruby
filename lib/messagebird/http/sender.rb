module MessageBird::HTTP
  class Sender
    class << self

      def deliver(sms)
        raise ArgumentError unless sms.is_a? MessageBird::HTTP::SMS

        response = send_sms(sms)
      end

    private

      def send_sms(sms)
        connection = create_connection(sms.uri)
        request    = Net::HTTP::Get.new(sms.request_uri)

        response = Response.new( connection.request(request) )
        pp response
        response
      end

      def create_connection(uri)
        Net::HTTP.new(uri.host, uri.port).tap do |http|
          http.use_ssl = true
          # http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
      end

    end
  end
end
