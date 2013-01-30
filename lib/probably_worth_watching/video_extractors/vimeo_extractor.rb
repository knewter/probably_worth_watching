require 'nokogiri'

module ProbablyWorthWatching
  module VideoExtractors
    class VimeoExtractor
      attr_reader :html

      def initialize(html)
        @html = html
      end

      def videos
        video_iframes.map{|iframe| iframe['src'] }
      end

      private
      def page
        @page ||= Nokogiri::HTML(html)
      end

      def video_iframes
        iframes.select{|iframe| iframe['src'] =~ /vimeo/ }
      end

      def iframes
        @iframes ||= page.css('iframe')
      end
    end
  end
end
