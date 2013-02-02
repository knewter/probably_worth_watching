require_relative '../../spec_helper'

describe VideoExtractors::YoutubeExtractor do
  describe "From a youtube embed" do
    before do
      sample_page_path = File.expand_path("../samples/page_with_youtube_embed.html", __FILE__)
      @sample_page = File.read(sample_page_path)
    end

    it "extracts urls for embedded youtube videos from a given html page" do
      extractor = VideoExtractors::YoutubeExtractor.new(@sample_page)
      expected_video_url = "http://www.youtube.com/v/jSPIDNkWAUg?fs=1&hl=en_US"
      extractor.videos.must_equal [expected_video_url]
    end
  end

  describe "From a youtube page" do
    before do
      sample_page_path = File.expand_path("../samples/youtube_page.html", __FILE__)
      @sample_page = File.read(sample_page_path)
    end

    it "extracts urls for embedded youtube videos from a given html page" do
      extractor = VideoExtractors::YoutubeExtractor.new(@sample_page)
      expected_video_url = "http://www.youtube.com/watch?v=foJhOrEaZG8"
      extractor.videos.must_equal [expected_video_url]
    end
  end
end
