require 'delegate'

class TweetWithLinks < SimpleDelegator
  attr_accessor :links

  def initialize(obj)
    super
    @links = []
  end

  def add_links(additional_links)
    additional_links.each do |link|
      links << link
    end
  end
end
