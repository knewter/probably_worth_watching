require_relative '../spec_helper'

describe FindsVideosFilter do
  it "rejects a tweet with no videos" do
    skip
    tweet = mock

    FindsVideosFilter.new.call(tweet).must_equal nil
  end

  it "returns a TweetWithVideo, if the input tweet had a video in it" do
    tweet = mock
    tweet.stubs(:links).returns [1]
    mock_html = mock 'html'
    HtmlGrabber.any_instance.stubs(:call).returns mock_html
    mock_video = mock 'video'
    VideoExtractors::VimeoExtractor.any_instance.expects(:videos).returns([mock_video]).at_least_once

    filter = FindsVideosFilter.new
    assert_instance_of TweetWithVideos, filter.call(tweet)
  end
end
