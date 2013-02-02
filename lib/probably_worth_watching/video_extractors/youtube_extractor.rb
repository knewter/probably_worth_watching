module ProbablyWorthWatching
  module VideoExtractors
    class YoutubeExtractor < BaseExtractor
      private
      def video_flash_objects
        flash_objects.select{|object| object['src'] =~ /youtube\.com/ }
      end

      def video_og_urls
        og_urls.select{|meta| meta['content'] =~ /youtube\.com/ }
      end
    end
  end
end
