module ProbablyWorthWatching
end

require 'data_mapper'

# If you want the logs displayed you have to do this before the call to setup
DataMapper::Logger.new($stdout, :debug)

# An in-memory Sqlite3 connection:
DataMapper.setup(:default, "sqlite:///#{File.expand_path('../../videos.sqlite', __FILE__)}")

require_relative 'probably_worth_watching/filter_chain'
require_relative 'probably_worth_watching/seconds'
require_relative 'probably_worth_watching/url'
require_relative 'probably_worth_watching/tweet'
require_relative 'probably_worth_watching/video'
require_relative 'probably_worth_watching/tweet_with_links'
require_relative 'probably_worth_watching/tweet_with_videos'
require_relative 'probably_worth_watching/finds_links_filter'
require_relative 'probably_worth_watching/finds_videos_filter'
require_relative 'probably_worth_watching/gets_tweets'
require_relative 'probably_worth_watching/logger'
require_relative 'probably_worth_watching/video_extractors'
require_relative 'probably_worth_watching/gathers_video_metadata_analyzer'
require_relative 'probably_worth_watching/adapters'
require_relative 'probably_worth_watching/persists_videos'
require_relative 'probably_worth_watching/fakes_irc_logs_as_tweets'
require_relative 'probably_worth_watching/irc_log_line_tweet_faker'

DataMapper.finalize
DataMapper.auto_upgrade!
