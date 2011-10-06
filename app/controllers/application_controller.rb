class ApplicationController < ActionController::Base
  include ApplicationHelper

  #after_filter :group_id_to_permalink

  protect_from_forgery

  protected
    def setup_theme
      self.class.view_paths = ::ActionController::Base.view_paths.dup.unshift("#{::Rails.root.to_s}/themes/default/views")
    end

    def theme_layout
      #if File.exists? "#{::Rails.root.to_s}/themes/#{ @group.theme }/views/layouts/default.html.erb"
      if action_name == "show" or (controller_name != "groups" && action_name == "index")
        prepend_view_path "#{::Rails.root.to_s}/themes/#{ @group.theme }/views"
        return "layouts/default.html.erb"
      end
      'application'
    end

end
