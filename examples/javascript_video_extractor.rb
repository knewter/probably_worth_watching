require_relative 'javascripters'
require_relative 'twitter_video_extractor'

TwitterVideoExtractor.new(Javascripters).extract_videos
