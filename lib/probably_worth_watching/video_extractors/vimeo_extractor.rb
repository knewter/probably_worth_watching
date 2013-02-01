require 'nokogiri'

module ProbablyWorthWatching
  module VideoExtractors
    class VimeoExtractor
      attr_reader :html

      def initialize(html)
        @html = html
      end

      def videos
        videos_from_iframes + videos_from_og_metadata
      end

      private
      def videos_from_iframes
        video_iframes.map{|iframe| iframe['src'] }
      end

      def videos_from_og_metadata
        video_og_urls.map{|meta| meta['content']}
      end

      def page
        @page ||= Nokogiri::HTML(html)
      end

      def video_iframes
        iframes.select{|iframe| iframe['src'] =~ /vimeo\.com/ }
      end

      def iframes
        @iframes ||= page.css('iframe')
      end

      def video_og_urls
        og_urls.select{|meta| meta['content'] =~ /vimeo\.com/ }
      end

      def og_urls
        @og_urls ||= page.css('head meta[property="og:url"]')
      end
    end
  end
end
