require_relative '../spec_helper'

describe TweetWithLinks do
  before do
    @mock_tweet = mock 'tweet'
  end

  subject { TweetWithLinks.new @mock_tweet }

  it 'delegates to the wrapped tweet' do
    @mock_tweet.expects(:foo)
    subject.foo
  end

  it 'supports add_links' do
    subject.add_links [1]
    subject.links.must_equal [1]
  end
end
