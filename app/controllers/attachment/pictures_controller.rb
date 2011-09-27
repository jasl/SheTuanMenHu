class Attachment::PicturesController < Attachment::BaseController

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