require_relative '../spec_helper'

describe FakesIrcLogsAsTweets do
  let(:input_string) do
    sample_log_path = File.expand_path("../samples/irc_log_sample.txt", __FILE__)
    @sample_page = File.read(sample_log_path)
  end

  subject { FakesIrcLogsAsTweets.new(input_string) }

  it "turns an irc log into an array of tweets" do
    subject.tweets.count.must_equal 2
    subject.tweets.first.must_be_kind_of ProbablyWorthWatching::Tweet
  end
end
