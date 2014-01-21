module MessageBird
  class SMS
    class << self
      include Helpers

      def deliver(originator, recipients, message, options={})
        new(originator, recipients, message, options).deliver
      end

      def new(originator, recipients, message, options={})
        module_name = options.delete(:module) || config.module
        klass_for(module_name).new(originator, recipients, message, options)
      end

    private

      def klass_for(module_name)
        constantize("MessageBird::#{module_name.to_s.upcase}::SMS")
      end

    end
  end
end
