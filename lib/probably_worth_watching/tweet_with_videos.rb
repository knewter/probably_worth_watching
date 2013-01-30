require 'delegate'

class TweetWithVideos < SimpleDelegator
  attr_accessor :videos

  def initialize(obj)
    super
    @videos = []
  end

  def add_videos(additional_videos)
    additional_videos.each do |video|
      videos << video
    end
  end
end
