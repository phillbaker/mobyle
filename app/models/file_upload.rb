# Class for uploads associated with Groups
class FileUpload < Upload
  belongs_to :group, :required => false # (Will also be created for parent objects so don't make this required)
  
end