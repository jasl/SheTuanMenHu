class GroupsController < ApplicationController
  before_filter :require_admin, :only => [:edit, :update]
  before_filter :require_login, :except => [:show, :index]
  before_filter :permitted_group, :except => [:new, :create, :index]
  before_filter :require_fulfill_profile, :only => [:new, :create]

  include GroupsHelper
  before_filter :group_header, :only => [:show]
  layout 'portal', :only => [:show]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    #@group = get_group params[:id]
    #@pages = Page.where(:state => true)
    @articles = Article.order("created_at DESC").where(:group_id => @group.id).limit(5)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: get_group(params[:id]) }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new
    @group.school = current_user.profile.school

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = get_group params[:id]
  end

  # POST /groups
  # POST /groups.json
  def create
    params[:group][:is_audited] = true # just for development

    params[:group][:school] = current_user.profile.school
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save and Member.create! :authority => 3, :is_audited => true, :profile_id => current_user.profile.id, :group_id => @group.id
        format.html { redirect_to root_path, notice: 'Group was successfully created. Need audit' }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = get_group params[:id]

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to manage_groups_url @group.permalink, notice: 'Group was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def search

  end
end
