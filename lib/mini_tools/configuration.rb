module MiniTools
  # Used to build simple configuration objects.
  #
  # ```
  # class SimpleConfig
  #   include MiniTools::Configuration
  #
  #   allow :value_1, value_2
  #   allow :value_3
  # end
  # ```
  #
  # Then we can set the values with
  #
  # ```
  # SimpleConfig.configure do |config|
  #   config.value_1 = 'some-value'
  #   config.value_2 = 'another-value'
  #   config.value_3 = 'a-third-value'
  # end
  # ```
  #
  # and access the values with
  #
  # ```
  # SimpleConfig.config.value_1 # some-value
  # ```
  module Configuration
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      # Adds values to the allowed list of settings. Accepts either a single
      # settings key or array and can be called multiple times.
      def allow *values
        @settings = settings.concat(values).uniq
      end

      # Returns the configuration object
      def config
        @config ||= Struct.new(*settings).new
      end

      # Accepts a block of configuration values
      def configure
        yield config
      end

      # Returns an array of allowed settings
      def settings
        @settings ||= []
      end
    end
  end
end
