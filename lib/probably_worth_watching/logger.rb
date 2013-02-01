module ProbablyWorthWatching
  class Logger
    attr_reader :io, :log_block

    def initialize(io, log_block=nil)
      @io = io
      @log_block = log_block || default_log_block
    end

    def call(object)
      @io << log_block.call(object)
      object
    end

    private
    def default_log_block
      lambda do |obj|
        obj.inspect
      end
    end
  end
end
