$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'bundler'
Bundler.require :development
Bundler.require

require 'active_record'
require 'paperclip_duplicate_check'

Paperclip::Railtie.insert
ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'test.sqlite'
)

class Person < ActiveRecord::Base
  include CheckForDuplicateAttachedFile

  has_attached_file :photo,
                    styles:  {
                               profile: '200x200>',
                               logbook: '32x32#',
                               stat:    '64x64#',
                             },
                    storage: :filesystem
  check_for_duplicate_attached_file :photo
end

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.before(:each) do
    Person.connection.execute "DROP TABLE IF EXISTS people"
    Person.connection.execute <<-SQL
      CREATE TABLE people (
        id INTEGER PRIMARY KEY ASC,
        photo_file_name VARCHAR(255),
        photo_content_type VARCHAR(255),
        photo_file_size INTEGER,
        photo_updated_at TIME,
        photo_fingerprint VARCHAR(64)
      )
    SQL

    Rails.stub!(:root).and_return(Pathname(Dir.getwd))
  end
end
