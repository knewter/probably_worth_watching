require_relative '../lib/probably_worth_watching'
include ProbablyWorthWatching

twitter_config = {
  consumer_key: ENV["TWITTER_CONSUMER_KEY"],
  consumer_secret: ENV["TWITTER_CONSUMER_SECRET"],
  oauth_token: ENV["TWITTER_OAUTH_TOKEN"],
  oauth_token_secret: ENV["TWITTER_OAUTH_TOKEN_SECRET"]
}

twitter = GetsTweets.new(twitter_config)

output = StringIO.new

twitter.tweets_from("knewter").each do |tweet|
  chain = FilterChain.new
  chain << FindsLinksFilter.new
  chain << Logger.new(output)
  chain.execute(tweet)
end

output.rewind
puts output.read
