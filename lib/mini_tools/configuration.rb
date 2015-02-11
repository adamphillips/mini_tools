module MiniTools
  module Configuration
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def allow *values
        @settings = settings.concat(values).uniq
      end

      def config
        @config ||= Struct.new(*settings).new
      end

      def configure
        yield config
      end

      def settings
        @settings ||= []
      end
    end
  end
end
