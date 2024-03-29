class Attachment::File < Attachment::Base
  has_attached_file :data,
                    :url => "/attachments/files/:id/:filename",
                    :path => ":rails_root/public/attachments/files/:id/:filename"
  
  validates_attachment_size :data, :less_than => 100.megabytes
  validates_attachment_presence :data
	
	def url_thumb
	  @url_thumb ||= begin
	    extname = File.extname(filename).gsub(/^\./, '')
      "/javascripts/ckeditor/filebrowser/images/thumbs/#{extname}.gif"
	  end
	end
end
