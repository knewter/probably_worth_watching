require 'pry'
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
        html = html_for_link(link)
        if(html)
          VideoExtractors::VimeoExtractor.new(html).videos
        else
          nil
        end
      end.flatten.compact
    end

    def html_for_link(link)
      html = HtmlGrabber.new(link).call
      if validate_content_type(html)
        html
      else
        STDOUT.puts "Found invalid content type: #{html.response.inspect}"
        nil
      end
    end

    def decorated_object(object)
      TweetWithVideos.new(object).tap do |tweet|
        tweet.add_videos(videos_for(object))
      end
    end

    def validate_content_type(html)
      valid_content_types.detect{|type| html.response.headers["Content-Type"] =~ type }
    end

    def valid_content_types
      [
        /^text\/html/
      ]
    end
  end
end
