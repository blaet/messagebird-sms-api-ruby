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

    def self.decode(string)
      RESPONSE_CODES[string] || raise(ResponseCodeNotFound.new(string))
    end

    RESPONSE_CODES = {
      "01" => ResponseCode.new(:success,                          "Request processed successfully"),
      "69" => ResponseCode.new(:message_cannot_schedule_on_date,  "Message cannot be scheduled on this date"),
      "70" => ResponseCode.new(:timestamp_incorrect,              "Timestamp notation invalid"),
      "71" => ResponseCode.new(:timestamp_in_past,                "Timestamp is in the past"),
      "72" => ResponseCode.new(:message_too_long,                 "Message is too long"),
      "89" => ResponseCode.new(:sender_invalid,                   "Sender invalid"),
      "93" => ResponseCode.new(:receivers_invalid,                "One or several receivers invalid"),
      "95" => ResponseCode.new(:message_not_selected,             "No message selected"),
      "96" => ResponseCode.new(:credits_insufficient,             "Insufficient credits"),
      "97" => ResponseCode.new(:login_invalid,                    "Invalid username and/or password"),
      "98" => ResponseCode.new(:ip_address_not_authorized,        "IP address is not authorized for this account"),
      "99" => ResponseCode.new(:connection_failed,                "Cannot connect to server")
    }
    # PREMIUM CODES NOT IMPLEMENTED YET

    class ResponseCodeNotFound < ArgumentError; end
  end
end
