module ProbablyWorthWatching
  class HtmlGrabber
    def initialize(url)
      @url = url
    end

    def call
      Http.with_follow(true).get(@url)
    end
  end
end
