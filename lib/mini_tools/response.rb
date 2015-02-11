module MiniTools
  class Response
    attr_reader :result, :args

    def initialize result, *args
      @result = result
      @args = args
    end

    def on *outcome
      yield(*args) if outcome.include?(result)
    end
  end
end
