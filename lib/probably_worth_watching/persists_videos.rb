require_relative 'html_grabber'

module ProbablyWorthWatching
  class PersistsVideos
    def call(object)
      object.videos.map{|v| possibly_persist(v) }
      object
    end

    private
    def possibly_persist(video)
      persist(video) unless exists?(video)
    end

    def persist(video)
      video.save
    end

    def exists?(video)
      Video.all(url: video.url).any?
    end
  end
end
