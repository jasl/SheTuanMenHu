class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery

  protected

=begin
  def ckeditor_filebrowser_scope(options = {})
    super
    {
        :assetable_id => current_user.id,
        :assetable_type => 'User'
    }.merge(options)
  end
=end
end
