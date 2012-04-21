# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name        = "paperclip_duplicate_check"
  gem.homepage    = "http://github.com/RISCfuture/paperclip_duplicate_check"
  gem.license     = "MIT"
  gem.summary     = %Q{Skips uploading a Paperclip attachment if it's identical to the one already uploaded}
  gem.description = %Q{This gem adds a mixin allowing you to forgo uploading a replacement Paperclip attachment if it's identical to the current attachment.}
  gem.email       = "git@timothymorgan.info"
  gem.authors     = ["Tim Morgan"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task default: :spec

require 'yard'
YARD::Rake::YardocTask.new('doc') do |doc|
  doc.options << '-m' << 'markdown' << '-M' << 'redcarpet'
  doc.options << '--protected' << '--no-private'
  doc.options << '-r' << 'README.md'
  doc.options << '-o' << 'doc'
  doc.options << '--title' << 'Paperclip Duplicate Checker Documentation'

  doc.files = %w( lib/**/* README.md )
end
