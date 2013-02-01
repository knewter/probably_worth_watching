require_relative '../spec_helper'

describe "Running a tweet through to get a video out" do
  before do
    @tweet = Tweet.new(author: 'knewter', content: ".@noelrap I just watched this and now I feel bad that I didn't watch it before now. Great stuff. http://t.co/lRqfmubL")
  end

  it "comes out the other side with a video on it" do
    chain = FilterChain.new
    chain << FindsLinksFilter.new
    chain << FindsVideosFilter.new
    chain << GathersVideoMetadataAnalyzer.new
    assert_equal 'http://vimeo.com/49525644', chain.execute(@tweet).videos[0].url
  end
end
