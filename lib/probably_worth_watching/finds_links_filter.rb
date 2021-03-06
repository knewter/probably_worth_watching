require 'uri'

module ProbablyWorthWatching
  class FindsLinksFilter
    def call(object)
      if has_links?(object)
        decorated_object(object)
      else
        nil
      end
    end

    private
    def has_links?(object)
      links_for(object).any?
    end

    def links_for(object)
      legitimate_links_from(extracted_links_for(object))
    end

    def legitimate_links_from(links)
      links.select do |link|
        begin
          URI.parse(link)
        rescue URI::InvalidURIError
          false
        rescue
          false
        end
      end
    end

    def extracted_links_for(object)
      URI.extract(object.content)
    end

    def decorated_object(object)
      TweetWithLinks.new(object).tap do |tweet|
        tweet.add_links(links_for(object))
      end
    end
  end
end
