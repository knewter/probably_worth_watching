require 'youtube_it'

module ProbablyWorthWatching
  module Adapters
    class YoutubeAdapter
      def initialize
        @client = YouTubeIt::Client.new
      end

      def get_video_info_for_url(url)
        Video.new.tap do |video|
          info = @client.video_by(url)
          video.duration = Seconds.new(info.duration)
          video.title = info.title
          video.description = info.description
          video.url = info.embed_url
        end
      end

      def self.handles_url?(url)
        url =~ /youtube.com/
      end
    end
  end
end
