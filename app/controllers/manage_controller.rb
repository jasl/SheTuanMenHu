class ManageController < ApplicationController
  include GroupsHelper
  before_filter :group_permalink_to_id

  before_filter :require_login
  before_filter :require_publisher
  before_filter :require_admin, :only => [:control]
  before_filter :permitted_group

  def articles
    @articles = Article.where(:group_id => params[:group_id]).page(params[:page]).order('created_at DESC')
  end

  def pages
    @pages = Page.where(:group_id => params[:group_id]).page(params[:page]).order('created_at DESC')
  end

  def index
    @group = get_group params[:id]
  end

  def control
     @members = Member.where(:group_id => params[:group_id]).order('authority DESC')
  end

end
