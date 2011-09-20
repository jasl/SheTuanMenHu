class ApplicationController < ActionController::Base
  include ApplicationHelper

  after_filter :group_id_to_permalink

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
