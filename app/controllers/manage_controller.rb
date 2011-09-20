class ManageController < ApplicationController
  before_filter :require_login
  before_filter :require_publisher
  before_filter :require_admin, :only => [:control]
  before_filter :permitted_group

  def articles
    @group = get_group params[:id]
    @articles = Article.all(:conditions => ['group_id = ?', @group])
  end

  def pages
    @group = get_group params[:id]
    @pages = Page.all(:conditions => ['group_id = ?', @group.id])
  end

  def index
    @group = get_group params[:id]
  end

  def control
     redirect_to root_path
  end

end
