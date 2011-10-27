class Attachment::FilesController < Attachment::BaseController

  def index
    @attachments = Attachment::File.where(attachments_scope)
    respond_with(@attachments)
  end

  def create
    @attachment = Attachment::File.new
	  respond_with_asset(@attachment)
  end

  def destroy
    @attachment.destroy
    respond_with(@attachment, :location => attachment_files_path)
  end

  protected

    def find_asset
      @attachment = Attachment::File.find(params[:id])
    end
end