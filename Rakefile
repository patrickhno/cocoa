# encoding: utf-8

PROJECT_SPECS = FileList['spec/**/*_spec.rb']

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "cocoa"
  gem.homepage = "http://github.com/patrickhno/cocoa"
  gem.license = "MIT"
  gem.summary = %Q{Ruby bindings for Cocoa}
  gem.description = %Q{Ruby FFI bindings for the OSX Cocoa API}
  gem.email = "patrick.hanevold@gmail.com"
  gem.authors = ["Patrick Hanevold"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

desc "Code coverage detail"
task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['bacon'].execute
end

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "cocoa #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Dir['tasks/*.rake'].each{|f| import(f) }

task :default => [:bacon]
