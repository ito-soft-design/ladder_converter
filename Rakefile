require "bundler/gem_tasks"
require "rake/testtask"
require 'ladder_converter'

ENV['TESTOPTS'] = "--max-diff-target-string-size=2000"
Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

task :default => :test
