require 'uri'
require 'virtus'

module ProbablyWorthWatching
  class Video
    include Virtus

    attribute :title, String
    attribute :description, String
    attribute :duration, Seconds
    attribute :url, Url
  end
end
