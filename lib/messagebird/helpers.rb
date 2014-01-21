module MessageBird
  module Helpers

    def config
      MessageBird::Config
    end

    def constantize(class_name)
      unless /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/ =~ class_name
        raise NameError, "#{class_name.inspect} is not a valid constant name!"
      end
      Object.module_eval("::#{$1}", __FILE__, __LINE__)
    end

    def escape(str)
      URI.escape(str)
    end

  end
end
