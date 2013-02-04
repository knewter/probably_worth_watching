module ProbablyWorthWatching
  class FakesIrcLogsAsTweets
    attr_reader :log
    def initialize(log)
      @log = log
    end

    def tweets
      lines.map do |line|
        IrcLogLineTweetFaker.new(line).make_tweet
      end
    end

    private
    def lines
      @log.split("\n")
    end
  end
end
