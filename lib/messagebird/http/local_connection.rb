require 'ostruct'

module MessageBird::HTTP
  class LocalConnection

    attr_writer :use_ssl

    def initialize(host, port)
    end

    def request(obj)
      OpenStruct.new(body: '01')
    end
  end
end
