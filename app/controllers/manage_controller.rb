class ManageController < ApplicationController
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
