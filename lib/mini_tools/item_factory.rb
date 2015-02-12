module MiniTools
  # The ItemFactory is used for creating instances of classes based on a map
  # of keys to classes. For example, assume we a list of commands to be run
  # that looks something like this
  # ```
  # commands = [
  #   [:notification_email, 'someone@somewhere.co.uk'],
  #   [:update_account, account_instance],
  # ]
  # ```
  # Each of these commands has an associated Command object.
  # Then we can create an ItemFactory to dynamically build the instances we
  # need
  #
  # ```
  # class CommandFactory
  #   include MiniTools::ItemFactory
  #
  #   map(
  #     notification_email: EmailNotifier,
  #     update_account: AccountUpdater
  #   )
  # end
  #
  # commands.each do |command, args|
  #   CommandFactory.build(command).execute(args)
  # end
  # ```
  #
  module ItemFactory
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      attr_reader :default_klass

      # Builds the appropriate item based on `value`. Any additional args are
      # passed on to the item's initializer
      def build value, *args
        klass_for(value).new(*args)
      end

      # Defines the map of values to class types
      def map values
        @klass_map = values
      end

      # Sets the default class if there is no match in the map
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
