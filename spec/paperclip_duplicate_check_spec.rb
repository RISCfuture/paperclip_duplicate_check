require 'spec_helper'

describe CheckForDuplicateAttachedFile do
  describe ".check_for_duplicate_attached_file" do
    it "should save an attachment if it's different from the current attachment" do
      person       = Person.create!(photo: Rack::Test::UploadedFile.new("#{Dir.getwd}/spec/fixtures/image.jpg", 'image/jpeg'))
      person.photo = Rack::Test::UploadedFile.new("#{Dir.getwd}/spec/fixtures/image2.png", 'image/png')
      person.photo.should be_dirty
      person.save!
      `md5 #{person.photo.path}`.split(' ').last.should eql(`md5 #{"#{Dir.getwd}/spec/fixtures/image2.png"}`.split(' ').last)
    end

    it "should not re-save an attachment if it's the same as the current attachment" do
      person       = Person.create!(photo: Rack::Test::UploadedFile.new("#{Dir.getwd}/spec/fixtures/image.jpg", 'image/jpeg'))
      person.photo = Rack::Test::UploadedFile.new("#{Dir.getwd}/spec/fixtures/image.jpg", 'image/jpeg')
      person.photo.should_not be_dirty
      person.save!
      p person.photo.path
      `md5 #{person.photo.path}`.split(' ').last.should eql(`md5 #{"#{Dir.getwd}/spec/fixtures/image.jpg"}`.split(' ').last)
    end
  end
end
