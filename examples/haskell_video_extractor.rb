require_relative 'haskellers'
require_relative 'twitter_video_extractor'

TwitterVideoExtractor.new(Haskellers).extract_videos
