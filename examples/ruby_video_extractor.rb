require 'celluloid'
require_relative '../lib/probably_worth_watching'
include ProbablyWorthWatching

twitter_config = {
  consumer_key: ENV["TWITTER_CONSUMER_KEY"],
  consumer_secret: ENV["TWITTER_CONSUMER_SECRET"],
  oauth_token: ENV["TWITTER_OAUTH_TOKEN"],
  oauth_token_secret: ENV["TWITTER_OAUTH_TOKEN_SECRET"]
}

class LogCollector < StringIO
  include Celluloid
end

output = LogCollector.new

class StdoutCollector
  include Celluloid

  def puts(str)
    STDOUT.puts str
  end

  def <<(str)
    STDOUT << str
  end
end

stdout_collector = StdoutCollector.new

def prefixer message
  lambda do |tweet|
    message + "\n" + tweet.inspect
  end
end

video_printer = lambda do |tweet|
  String.new.tap do |s|
    s << tweet.inspect + "\n"
    tweet.videos.each do |video|
      s << "title: " + video.title + "\n"
      s << "description: " + video.description + "\n"
      s << "url: " + video.url + "\n"
      s << "----------" + "\n" + "\n"
    end
  end
end

twitter = GetsTweets.new(twitter_config)

tweeters = %w(
  JEG2
  avdi
  bascule
  knewter
  adamgamble
  chadfowler
  defunkt
  pragdave
  david_a_black
  drnic
  dhh
  drbrain
  evanphx
  ezmobius
  AkitaOnRails
  topfunky
  gilesgoatboy
  jimweirich
  peterc
  wycats
)

futures = []

twitter.tweets_from(tweeters).each do |tweet|
  futures << Celluloid::Future.new do
    chain = FilterChain.new
    chain << FindsLinksFilter.new
    chain << ProbablyWorthWatching::Logger.new(stdout_collector, prefixer("Got past FindsLinksFilter"))
    chain << FindsVideosFilter.new
    chain << ProbablyWorthWatching::Logger.new(stdout_collector, prefixer("================= Got past FindsVideosFilter ==================="))
    chain << GathersVideoMetadataAnalyzer.new
    chain << ProbablyWorthWatching::Logger.new(output, video_printer)
    begin
      Timeout::timeout(120) do
        chain.execute(tweet)
      end
    rescue Timeout::Error
      stdout_collector.puts "There was a timeout for one of the chains, ignoring..."
    end
  end
end

futures.map(&:value)

output.rewind
puts "\n\n\n----------------------------\n"
puts output.read
