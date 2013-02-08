require 'vimeo'

module ProbablyWorthWatching
  module Adapters
    class VimeoAdapter
      def initialize
      end

      def get_video_info_for_url(url)
        get_video_info(extract_id_from_url(url))
      end

      def self.handles_url?(url)
        url =~ /vimeo.com/
      end

      private
      def get_video_info(id)
        Video.new.tap do |video|
          info = get_video_info_in_vimeo_format(id)
          video.duration = Seconds.new(info['duration'])
          video.title = info['title']
          video.description = info['description']
          video.url = info['url']
          video.embed = %Q(<iframe src="http://player.vimeo.com/video/#{id}" width="960" height="540" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>)
        end
      end

      def extract_id_from_url(url)
        URI.parse(url).path.split('/')[-1]
      end

      def get_video_info_in_vimeo_format(id)
        Vimeo::Simple::Video.info(id)[0]
      end
    end
  end
end
