module ProbablyWorthWatching
  module VideoExtractors
    class VimeoExtractor < BaseExtractor
      def video_iframes
        iframes.select{|iframe| iframe['src'] =~ /vimeo\.com/ }
      end

      def video_og_urls
        og_urls.select{|meta| meta['content'] =~ /vimeo\.com/ }
      end
    end
  end
end
