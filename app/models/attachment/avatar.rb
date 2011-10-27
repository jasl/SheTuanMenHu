class Attachment::Avatar < Attachment::Base
  has_attached_file :data,
                    :url  => "/attachments/pictures/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/attachments/pictures/:id/:style_:basename.:extension",
	                  :styles => { :content => '200>' }
	
	validates_attachment_size :data, :less_than => 1.megabytes
	validates_attachment_presence :data
	
	def url_content
	  url(:content)
	end
end

