$:.unshift File.expand_path(File.join(File.dirname(__FILE__), 'lib'))

require 'rake/testtask'
require 'mel2kv'

task :default => :test

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*_test.rb']
  t.warning = true
end

__END__

desc "Convert FX device to KV device."
task :kvdevice do
  plc = Mel2Kv.new
  loop do
    print "Input FX device name: "
    dev_name = STDIN.gets.chomp
    case dev_name
    when "quit", "q"
      break
    else
      puts "KV device name => #{plc.to_kv_device(dev_name)}"
      puts
    end
  end
end
