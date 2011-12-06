require './phaser_store'
require 'sinatra/activerecord/rake'

require 'rake/testtask'

Rake::TestTask.new do |t| 
  t.libs.push "lib", "models"
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end
