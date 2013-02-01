require_relative '../lib/probably_worth_watching'
include ProbablyWorthWatching

twitter_config = {
  consumer_key: ENV["TWITTER_CONSUMER_KEY"],
  consumer_secret: ENV["TWITTER_CONSUMER_SECRET"],
  oauth_token: ENV["TWITTER_OAUTH_TOKEN"],
  oauth_token_secret: ENV["TWITTER_OAUTH_TOKEN_SECRET"]
}

output = StringIO.new

video_printer = lambda do |tweet|
  String.new.tap do |s|
    s << tweet.inspect + "\n"
    tweet.videos.each do |video|
      s << video.title + "\n"
      s << video.description + "\n"
      s << video.url + "\n"
      s << "----------" + "\n" + "\n"
    end
  end
end

twitter = GetsTweets.new(twitter_config)

twitter.tweets_from(%w(knewter adamgamble)).each do |tweet|
  chain = FilterChain.new
  chain << FindsLinksFilter.new
  chain << FindsVideosFilter.new
  chain << GathersVideoMetadataAnalyzer.new
  chain << Logger.new(output, video_printer)
  chain.execute(tweet)
end

output.rewind
puts output.read
