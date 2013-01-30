require 'rake/testtask'

task default: %w(spec)

desc "Run the specs"
task spec: %w(spec:units)

namespace :spec do
  Rake::TestTask.new do |t|
    t.name = 'units'
    t.test_files = FileList['spec/units/**/*_spec.rb']
  end
end
