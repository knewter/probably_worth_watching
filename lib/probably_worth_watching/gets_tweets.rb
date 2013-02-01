require 'twitter'
module ProbablyWorthWatching
  class GetsTweets
    attr_reader :twitter
    def initialize(configuration)
      @twitter = Twitter::Client.new(configuration)
    end

    def tweets_from(users)
      users = [users] unless users.respond_to?(:each)
      users.map do |user|
        @twitter.user_timeline(user).map do |twitter_tweet|
          Tweet.new(author: twitter_tweet.user.screen_name, content: twitter_tweet.text)
        end
      end.flatten
    end
  end
end
