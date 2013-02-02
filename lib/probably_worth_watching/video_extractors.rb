require_relative "./video_extractors/base_extractor"
require_relative "./video_extractors/vimeo_extractor"
require_relative "./video_extractors/youtube_extractor"

module ProbablyWorthWatching
  module VideoExtractors
    def self.extract_videos(html)
      extractors.map do |extractor|
        extractor.new(html).videos
      end.flatten
    end

    def self.extractors
      [
        VimeoExtractor,
        YoutubeExtractor
      ]
    end
  end
end
