require "bundler/gem_tasks"
require "rake/testtask"
require 'ladder_converter'
require 'fileutils'

include FileUtils

ENV['TESTOPTS'] = "--max-diff-target-string-size=2000"
Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

desc 'Generate exe file'
task :genexe do
  begin
    mkdir_p 'tmp'
    `ocra exe/ladder_converter --output tmp/ldconv.exe`
  rescue
    puts '*' * 40
    puts "If an error occurred, try this command."
    puts "'gem install ocra'"
    puts '*' * 40
    raise
  end
end

task :default => :test
