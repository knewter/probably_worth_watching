require 'uri'
require 'data_mapper'

module ProbablyWorthWatching
  class Video
    include DataMapper::Resource

    property :id, Serial
    property :title, Text
    property :description, Text
    property :duration, Object
    property :url, Object
  end
end
