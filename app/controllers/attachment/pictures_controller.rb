class Attachment::PicturesController < Attachment::BaseController

  def index
    @pictures = Attachment::Picture.where(attachments_scope)
    respond_with(@pictures)
  end

  def create
    @picture = Attachment::Picture.new
	  respond_with_asset(@picture)
  end

  def destroy
    @picture.destroy
    respond_with(@picture, :location => attachment_pictures_path)
  end

  protected

    def find_asset
      @picture = Attachment::Picture.find(params[:id])
    end
end