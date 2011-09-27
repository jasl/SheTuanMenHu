class ApplicationController < ActionController::Base
  include ApplicationHelper

  #after_filter :group_id_to_permalink

  protect_from_forgery

  protected

    def set_paths
     prepend_view_path "#{::Rails.root.to_s}/themes/default/views"
    end

    def setup_theme
      self.class.view_paths = ::ActionController::Base.view_paths.dup.unshift("#{::Rails.root.to_s}/themes/default/views")
    end

=begin
    def theme_layout
      if self.action_name == 'show'
        prepend_view_path "#{::Rails.root.to_s}/themes/default/views"
        if File.exists? "#{::Rails.root.to_s}/themes/default/views/layouts/default.html.erb"
          return "layouts/default.html.erb"
        end
      end
      'application'
    end
=end

    def theme_layout
      if File.exists? "#{::Rails.root.to_s}/themes/#{ @group.theme }/views/layouts/default.html.erb"
        prepend_view_path "#{::Rails.root.to_s}/themes/#{ @group.theme }/views"
        return "layouts/default.html.erb"
      end
      'application'
    end
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
