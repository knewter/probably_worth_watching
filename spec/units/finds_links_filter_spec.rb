require_relative '../spec_helper'

describe FindsLinksFilter do
  subject { FindsLinksFilter.new }

  it "rejects a tweet with no links" do
    tweet = Tweet.new(content: "No links here...")
    FindsLinksFilter.new.call(tweet).must_equal nil
  end

  it "returns a TweetWithLinks, if the input tweet had a link in it" do
    tweet = Tweet.new(content: "A link! http://slashdot.org")
    FindsLinksFilter.new.call(tweet).links.must_equal ["http://slashdot.org"]
  end
end
