require 'celluloid'
require 'each_with_progress'

require_relative '../lib/probably_worth_watching'
include ProbablyWorthWatching

class IrcVideoExtractor
  def initialize(log)
    @log = log
  end

  def extract_videos
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

    fake_tweets = FakesIrcLogsAsTweets.new(@log).tweets

    # run a certain number at a time max
    work_pool = PoolingWorker.pool(size: 100)

    futures = []

    fake_tweets.each_with_progress do |tweet|
      futures << work_pool.future.execute do
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

    STDOUT.puts "OK, get the futures"

    futures.each_with_progress do |f|
      f.value
    end

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

  class PoolingWorker
    include Celluloid

    def execute &block
      yield
    end
  end
end
