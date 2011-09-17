class ManageController < ApplicationController
  before_filter :require_login
  before_filter :require_publisher
  before_filter :require_admin, :only => [:control]
  before_filter :permitted_group

  def articles
    @articles = Article.all(:conditions => ['group_id = ?', params[:id]])
    @group = params[:id]
  end

  def pages
    @pages = Page.all(:conditions => ['group_id = ?', params[:id]])
    @group = params[:id]
  end

  def index
    @group = Group.find(params[:id])
  end

  def control

  end

end
