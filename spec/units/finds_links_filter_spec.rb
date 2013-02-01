require_relative '../spec_helper'

describe FindsLinksFilter do
  it "rejects a tweet with no links" do
    tweet = Tweet.new(content: "No links here...")
    FindsLinksFilter.new.call(tweet).must_equal nil
  end

  it "returns a TweetWithLinks, if the input tweet had a link in it" do
    tweet = Tweet.new(content: "A link! http://slashdot.org")
    FindsLinksFilter.new.call(tweet).links.must_equal ["http://slashdot.org"]
  end

  it "ignores non-links that URI.extract thinks are ok" do
    tweet = Tweet.new(content: "This is not a link! bascule:")
    FindsLinksFilter.new.call(tweet).must_equal nil
  end
end
