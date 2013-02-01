require 'http'
require_relative 'html_grabber'

module ProbablyWorthWatching
  class FindsVideosFilter
    def call(object)
      if has_videos?(object)
        decorated_object(object)
      else
        nil
      end
    end

    private
    def has_videos?(object)
      videos_for(object).any?
    end

    def videos_for(object)
      object.links.map do |link|
        VideoExtractors::VimeoExtractor.new(html_for_link(link)).videos
      end.flatten
    end

    def html_for_link(link)
      HtmlGrabber.new(link).call
    end

    def decorated_object(object)
      TweetWithVideos.new(object).tap do |tweet|
        tweet.add_videos(videos_for(object))
      end
    end
  end
end
