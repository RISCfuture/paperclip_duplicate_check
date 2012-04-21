# Adds Paperclip duplicate-checking to your model.
#
# @example
#   class MyModel < ActiveRecord::Base
#     include CheckForDuplicateAttachedFile
#     has_attachment :foo
#     check_for_duplicate_attached_file :foo
#   end

module CheckForDuplicateAttachedFile
  extend ActiveSupport::Concern

  # Methods added to the class.

  module ClassMethods

    # @overload check_for_duplicate_attached_file(name, ...)
    #   Marks one or more attachments as performing duplicate checking.
    #   @param [Symbol] name An attachment name.

    def check_for_duplicate_attached_file(*names)
      names.each do |name|
        define_method :"#{name}_with_dup_check=" do |file|
          attachment = send(name)
          old_fingerprint = attachment.fingerprint
          send :"#{name}_without_dup_check=", file
          if attachment.fingerprint == old_fingerprint then
            # restore to saved state
            attachment.instance_variable_set :@queued_for_delete, []
            attachment.instance_variable_set :@queued_for_write, {}
            attachment.instance_variable_set :@errors, {}
            attachment.instance_variable_set :@dirty, false
          end
        end
        alias_method_chain :"#{name}=", :dup_check
      end
    end
  end
end
