module ProbablyWorthWatching
  class GathersVideoMetadataAnalyzer
    def initialize
    end

    def call(object)
      decorated_object(object)
    end

    private
    def decorated_object(object)
      begin
        TweetWithVideos.new(object.__getobj__).tap do |t|
          videos = object.videos.map do |url|
            Adapters.adapter_for(url).new.get_video_info_for_url(url)
          end
          t.add_videos videos
        end
      rescue
        STDOUT.puts "GathersVideoMetadataAnalyzer failed on #{object.inspect}\n"
        STDOUT.puts object.videos.join("\n")
        STDOUT.puts "---------------\n"
        nil
      end
    end
  end
end
