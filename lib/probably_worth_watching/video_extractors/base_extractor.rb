require 'nokogiri'

module ProbablyWorthWatching
  module VideoExtractors
    class BaseExtractor
      attr_reader :html

      def initialize(html)
        @html = html
      end

      def videos
        videos_from_iframes + videos_from_og_metadata + videos_from_flash_objects
      end

      private
      def videos_from_iframes
        video_iframes.map{|iframe| iframe['src'] }
      end

      def videos_from_og_metadata
        video_og_urls.map{|meta| meta['content']}
      end

      def videos_from_flash_objects
        video_flash_objects.map{|object| object['src']}
      end

      def page
        @page ||= Nokogiri::HTML(html)
      end

      def video_iframes
        # implement video_iframes in each extractor that needs to pull iframes
        []
      end

      def iframes
        @iframes ||= page.css('iframe')
      end

      def video_og_urls
        # implement video_og_urls in each extractor
        []
      end

      def video_flash_objects
        # implement video_flash_objects in each extractor
        []
      end

      def og_urls
        @og_urls ||= page.css('head meta[property="og:url"]')
      end

      def flash_objects
        page.css('object embed')
      end
    end
  end
end
