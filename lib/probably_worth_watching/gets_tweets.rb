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
        begin
          @twitter.user_timeline(user).map do |twitter_tweet|
            Tweet.new(author: twitter_tweet.user.screen_name, content: twitter_tweet.text)
          end
        rescue Twitter::Error::NotFound
          STDOUT.puts "Couldn't find twitter user: #{user}"
          []
        rescue Twitter::Error::Unauthorized
          STDOUT.puts "This guy's unauthorized: #{user}"
          []
        end
      end.flatten
    end
  end
end
