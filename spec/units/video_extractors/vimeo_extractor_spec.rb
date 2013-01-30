require_relative '../../spec_helper'

describe VideoExtractors::VimeoExtractor do
  before do
    sample_page_path = File.expand_path("../samples/page_with_vimeo_embed.html", __FILE__)
    @sample_page = File.read(sample_page_path)
  end

  it "extracts urls for embedded vimeo videos from a given html page" do
    extractor = VideoExtractors::VimeoExtractor.new(@sample_page)
    expected_video_url = "http://player.vimeo.com/video/49525644?badge=0"
    extractor.videos.must_equal [expected_video_url]
  end
end
