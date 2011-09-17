class Ckeditor::AttachmentFile < Asset::AttachmentFile
  def self.sti_name
    "Asset::AttachmentFile"
  end
end
