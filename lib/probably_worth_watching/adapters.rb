require_relative './adapters/vimeo_adapter'
require_relative './adapters/youtube_adapter'

module ProbablyWorthWatching
  module Adapters
    def self.adapter_for(url)
      adapters.detect{|a| a.handles_url?(url) }
    end

    def self.adapters
      [
        VimeoAdapter,
        YoutubeAdapter
      ]
    end
  end
end
