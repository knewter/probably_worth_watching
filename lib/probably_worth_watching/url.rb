module ProbablyWorthWatching
  class Url
    attr_reader :uri

    def initialize(string)
      @uri = URI.parse(string)
    end
  end
end
