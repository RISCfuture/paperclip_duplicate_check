Paperclip Duplicate Checker
===========================

|             |                                 |
|:------------|:--------------------------------|
| **Author**  | Tim Morgan                      |
| **Version** | 1.0 (Apr 20, 2012)              |
| **License** | Released under the MIT license. |

This class extends Paperclip, adding a feature that forgoes uploading a
replacement for an existing attachment file if the replacement is identical to
the existing file.

In order for this to work, your model _must_have an `<attachment>_fingerprint`
column, since MD5 fingerprints are used for comparison. To use, simply follow
this example:

```` ruby
class MyModel < ActiveRecord::Base
  include CheckForDuplicateAttachedFile
  has_attachment :note
  check_for_duplicate_attached_file :note
end
````

Et voila! You save on bandwidth costs if your code re-uploads a lot of the same
files.
