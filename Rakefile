require 'rake/testtask'

task default: %w(spec)

desc "Run the specs"
task spec: %w(spec:units spec:integration)

namespace :spec do
  Rake::TestTask.new do |t|
    t.name = 'units'
    t.test_files = FileList['spec/units/**/*_spec.rb']
  end

  Rake::TestTask.new do |t|
    t.name = 'integration'
    t.test_files = FileList['spec/integration/**/*_spec.rb']
  end
end

namespace :example do
  desc "Extract videos from rubyists"
  task :rubyist_video_extractor do
    require_relative 'examples/rubyists'
    require_relative 'examples/twitter_video_extractor'

    TwitterVideoExtractor.new(Rubyists).extract_videos
  end

  desc "Extract videos from javascripters"
  task :javascripter_video_extractor do
    require_relative 'examples/javascripters'
    require_relative 'examples/twitter_video_extractor'

    TwitterVideoExtractor.new(Javascripters).extract_videos
  end

  desc "Extract videos"
  task extract_videos: %w(rubyist_video_extractor javascripter_video_extractor)
end
