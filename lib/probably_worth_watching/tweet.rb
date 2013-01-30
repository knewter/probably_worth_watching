require 'virtus'

module ProbablyWorthWatching
  class Tweet
    include Virtus

    attribute :author, String
    attribute :content, String
  end
end
