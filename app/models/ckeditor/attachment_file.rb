class Ckeditor::AttachmentFile < Attachment::File
  def self.sti_name
    "Attachment::File"
  end
end
