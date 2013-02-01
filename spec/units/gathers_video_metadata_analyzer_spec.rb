require_relative '../spec_helper'

describe GathersVideoMetadataAnalyzer do
  let(:mock_vimeo_metadata){  mock 'vimeo metadata' }
  let(:mock_vimeo_video_url){ mock 'vimeo video url' }
  let(:tweet_with_videos) do
    mock('tweet with videos').tap do |t|
      t.stubs(:videos).returns([mock_vimeo_video_url])
      t.stubs(:__getobj__).returns(mock)
    end
  end
  subject{ GathersVideoMetadataAnalyzer.new }

  describe "calling" do
    before do
      Adapters::VimeoAdapter.any_instance.expects(:get_video_info_for_url).with(mock_vimeo_video_url)
    end

    it "returns a TweetWithVideos" do
      assert_instance_of TweetWithVideos, subject.call(tweet_with_videos)
    end
  end
end
