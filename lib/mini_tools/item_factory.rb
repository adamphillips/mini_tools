module MiniTools
  module ItemFactory
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      attr_reader :default_klass

      def build value, *args
        klass_for(value).new(*args)
      end

      def map values
        @klass_map = values
      end

      def default klass
        @default_klass = klass
      end

      private

      def klass_map
        @klass_map ||= {}
      end

      def klass_for value
        value = value.call if value.respond_to? :call
        return klass_map[value] if klass_map.has_key? value
        return default_klass
      end
    end
  end
end
