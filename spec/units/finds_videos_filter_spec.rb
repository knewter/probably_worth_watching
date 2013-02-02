require_relative '../spec_helper'

describe FindsVideosFilter do
  let(:mock_html) do
    mock_response = mock 'response'
    mock_response.stubs(:headers).returns({"Content-Type" => "text/html"})
    mock_html = mock 'html'
    mock_html.stubs(:response).returns mock_response
    mock_html
  end

  it "rejects a tweet with no videos" do
    tweet = mock
    tweet.stubs(:links).returns [1]
    HtmlGrabber.any_instance.stubs(:call).returns mock_html
    VideoExtractors::VimeoExtractor.any_instance.expects(:videos).returns([]).at_least_once
    VideoExtractors::YoutubeExtractor.any_instance.expects(:videos).returns([]).at_least_once

    assert_equal nil, FindsVideosFilter.new.call(tweet)
  end

  it "returns a TweetWithVideo, if the input tweet had a video in it" do
    tweet = mock
    tweet.stubs(:links).returns [1]
    HtmlGrabber.any_instance.stubs(:call).returns mock_html
    mock_video = mock 'video'
    VideoExtractors::VimeoExtractor.any_instance.expects(:videos).returns([mock_video]).at_least_once
    VideoExtractors::YoutubeExtractor.any_instance.expects(:videos).returns([]).at_least_once

    filter = FindsVideosFilter.new
    assert_instance_of TweetWithVideos, filter.call(tweet)
  end
end
