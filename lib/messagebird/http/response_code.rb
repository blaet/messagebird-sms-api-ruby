module MessageBird::HTTP
  class ResponseCode

    def initialize(symbol, description)
      @symbol      = symbol
      @description = description
    end

    def to_sym
      @symbol
    end

    def to_s
      @description
    end

    def ==(other)
      if other.is_a? Symbol
        self.to_sym == other
      else
        self.to_s == other
      end
    end
  end
end
