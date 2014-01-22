module MessageBird::HTTP
  class Response

    attr_reader :response_code

    def initialize( http_response )
      raise ArgumentError unless http_response.respond_to?(:body)
      @response_code = ResponseCode.decode(http_response.body)
    end

  end
end
