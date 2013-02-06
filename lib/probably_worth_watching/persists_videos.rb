require_relative 'html_grabber'

module ProbablyWorthWatching
  class PersistsVideos
    def call(object)
      object.videos.map(&:save)
      object
    end
  end
end
