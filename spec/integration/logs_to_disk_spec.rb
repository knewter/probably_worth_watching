require_relative '../spec_helper'

describe "Running a tweet through and having it logged to an IO object" do
  before do
    @tweet = Tweet.new(author: 'knewter', content: ".@noelrap I just watched this and now I feel bad that I didn't watch it before now. Great stuff. http://t.co/lRqfmubL")
  end

  it "writes the inspected tweet to the IO the logger was instantiated against" do
    s = StringIO.new
    chain = FilterChain.new
    chain << ProbablyWorthWatching::Logger.new(s)
    chain.execute(@tweet)
    s.rewind
    output = s.read
    assert_equal @tweet.inspect, output
  end
end
