require_relative 'irc_video_extractor'

log = ""
ARGV.each do |file_path|
  file_contents = File.read(file_path).encode('utf-8')
  log << file_contents
end

IrcVideoExtractor.new(log).extract_videos
