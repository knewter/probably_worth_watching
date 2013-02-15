require 'celluloid'
require_relative '../lib/probably_worth_watching'
include ProbablyWorthWatching

class TwitterVideoExtractor
  attr_reader :tweeters

  def initialize(twitter_handle_getter)
    @tweeters = twitter_handle_getter.new.twitter_handles
  end

  def extract_videos
    twitter_config = {
      consumer_key: ENV["TWITTER_CONSUMER_KEY"],
      consumer_secret: ENV["TWITTER_CONSUMER_SECRET"],
      oauth_token: ENV["TWITTER_OAUTH_TOKEN"],
      oauth_token_secret: ENV["TWITTER_OAUTH_TOKEN_SECRET"]
    }

    output = LogCollector.new

    stdout_collector = StdoutCollector.new

    video_printer = lambda do |tweet|
      String.new.tap do |s|
        s << tweet.inspect + "\n"
        tweet.videos.each do |video|
          s << "title: " + video.title.to_s + "\n"
          s << "description: " + video.description.to_s + "\n"
          s << "url: " + video.url.to_s + "\n"
          s << "----------" + "\n" + "\n"
        end
      end
    end

    twitter = GetsTweets.new(twitter_config)

    class PoolingWorker
      include Celluloid

      def execute(tweet)
        chain = FilterChain.new
        chain << FindsLinksFilter.new
        #chain << ProbablyWorthWatching::Logger.new(stdout_collector, prefixer("Got past FindsLinksFilter"))
        chain << FindsVideosFilter.new
        #chain << ProbablyWorthWatching::Logger.new(stdout_collector, prefixer("================= Got past FindsVideosFilter ==================="))
        chain << GathersVideoMetadataAnalyzer.new
        chain << PersistsVideos.new
        #chain << ProbablyWorthWatching::Logger.new(output, video_printer)
        begin
          Timeout::timeout(120) do
            chain.execute(tweet)
          end
        rescue Timeout::Error
          #stdout_collector.puts "There was a timeout for one of the chains, ignoring..."
        end
      end
    end

    # run a certain number at a time max
    work_pool = PoolingWorker.pool(size: 100)

    futures = []

    twitter.tweets_from(tweeters).each do |tweet|
      futures << work_pool.future.execute(tweet)
    end

    futures.map(&:value)

    output.rewind
    puts "\n\n\n----------------------------\n"
    puts output.read
  end

  private
  def prefixer message
    lambda do |tweet|
      message + "\n" + tweet.inspect
    end
  end

  class LogCollector < StringIO
    include Celluloid
  end

  class StdoutCollector
    include Celluloid

    def puts(str)
      STDOUT.puts str
    end

    def <<(str)
      STDOUT << str
    end
  end
end
