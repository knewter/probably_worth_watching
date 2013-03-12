require_relative '../../spec_helper'

describe GetsTweets do
  let(:twitter_configuration_data) do
    {
      consumer_key: 'consumer_key',
      consumer_secret: 'consumer_secret',
      oauth_token: 'oauth_token',
      oauth_token_secret: 'oauth_token_secret'
    }
  end

  it 'configures the Twitter gem appropriately' do
    Twitter::Client.expects(:new).with(twitter_configuration_data)
    GetsTweets.new(twitter_configuration_data)
  end

  describe "with a mocked twitter client" do
    let(:mock_client){ mock 'mock_client' }
    subject{ GetsTweets.new({}) }
    before do
      Twitter::Client.stubs(:new).returns(mock_client)
    end

    it "fetches a given users tweets" do
      mock_client.expects(:user_timeline).with("foo").returns([])
      subject.tweets_from("foo")
    end

    it "fetches multiple users tweets" do
      mock_client.expects(:user_timeline).with("foo").returns([])
      mock_client.expects(:user_timeline).with("bar").returns([])
      subject.tweets_from(["foo", "bar"])
    end

    it "returns Tweet value objects" do
      mock_twitter_tweet = mock 'twitter_tweet'
      mock_tweeter = mock 'user'
      mock_tweeter.expects(:screen_name)
      mock_twitter_tweet.expects(:text)
      mock_twitter_tweet.expects(:user).returns(mock_tweeter)
      mock_client.stubs(:user_timeline).returns([mock_twitter_tweet])
      assert_instance_of ProbablyWorthWatching::Tweet, subject.tweets_from("foo").first
    end
  end
end
