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
    property :embed, Text

    def to_json(*a)
      {
        title: title,
        description: description,
        duration: duration.number,
        url: url,
        embed: embed
      }
    end
  end
end
