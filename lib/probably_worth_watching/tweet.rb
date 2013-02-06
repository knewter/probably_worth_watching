require 'data_mapper'

module ProbablyWorthWatching
  class Tweet
    include DataMapper::Resource

    property :id, Serial
    property :author, String
    property :content, String
  end
end
