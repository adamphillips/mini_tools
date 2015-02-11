require 'mini_tools/response'

module MiniTools
  module Command
    def response result, *args
      Response.new(result, *args)
    end
  end
end
