$LOAD_PATH.unshift File.dirname(__FILE__)

require 'message_bird/config'

module MessageBird

  def self.method_missing(method, *args)
    if method.to_s[-1,1] == '='
      MessageBird::Config.send method.to_s.tr('=','').to_sym, args.first
    else
      MessageBird::Config.send method
    end
  end

end
