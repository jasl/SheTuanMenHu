class Attachment::Picture < Attachment::Base
  has_attached_file :data,
                    :url  => "/attachments/pictures/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/attachments/pictures/:id/:style_:basename.:extension",
	                  :styles => { :original =>'800>', :content => '500>', :thumb => '118x100#' }
	
	validates_attachment_size :data, :less_than => 2.megabytes
	validates_attachment_presence :data
	
	def url_content
	  url(:content)
	end
end

