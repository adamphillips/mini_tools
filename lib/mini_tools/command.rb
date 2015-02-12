require 'mini_tools/response'

module MiniTools
  # Creates a very simple command object using the MiniTools::Response class
  #
  # ```
  # class SimpleCommand
  #   def call value
  #     yield response :success, 'It worked' if value == true
  #     yield response :failure, 'It failed' if value == false
  #   end
  # end
  # ```
  #
  # Then use with
  #
  # SimpleCommand.new.call some_value do |response|
  #   response.on(:success) ->(message) { puts 'Successful'; puts message }
  #   response.on(:failure) ->(message) { puts 'Unsuccessful'; puts message }
  # end
  module Command
    def response result, *args
      Response.new(result, *args)
    end
  end
end
