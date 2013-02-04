class IrcLogLineTweetFaker
  attr_reader :log_line
  def initialize(log_line)
    @log_line = log_line
  end

  def make_tweet
    Tweet.new.tap do |t|
      t.author = author
      t.content = content
    end
  end

  private
  def author
    author_catcher.match(log_line)[1].strip rescue ""
  end

  def content
    content_catcher.match(log_line)[1].strip rescue ""
  end

  def author_catcher
    /<(.*)>/
  end

  def content_catcher
    /<.*> (.*)/
  end
end
