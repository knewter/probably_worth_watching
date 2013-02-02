module ProbablyWorthWatching
  class HtmlGrabber
    def initialize(url, options = {})
      @url = url
      @options = options
    end

    def call
      STDOUT.puts @url
      begin
        response = HTTParty.get(@url)
      rescue
        STDOUT.puts "There was an error getting #{@url}.  Moving on..."
        return nil
      end
      if validate_content_type(response)
        response.body
      else
        STDOUT.puts "Found invalid content type at #{@url}: #{response.headers['Content-Type']}"
        nil
      end
    end

    private
    def validate_content_type(response)
      valid_content_types.detect{|type| response.headers["Content-Type"] =~ type }
    end

    def valid_content_types
      @options[:valid_content_types] || default_valid_content_types
    end

    def default_valid_content_types
      [
        /^text\/html/
      ]
    end
  end
end
