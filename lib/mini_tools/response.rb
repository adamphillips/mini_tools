module MiniTools
  class Response
    attr_reader :result, :args

    def initialize command, result, *args
      @command = command
      @result = result
      @args = args
    end

    def on *outcome, &block
      handle_response(&block) if outcome.include?(result)
    end

    def else &block
      handle_response(&block) if !command.handled?
    end

    private

    attr_reader :command

    def handle_response
      command.handled = true
      yield(*args)
    end
  end
end
