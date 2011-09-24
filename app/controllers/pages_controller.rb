class PagesController < ApplicationController
  before_filter :require_login, :except => [:show, :index]
  before_filter :permitted_group
  before_filter :require_publisher, :except => [:show, :index]

  include GroupsHelper
  before_filter :set_group_template, :only => [:show]
  layout :theme_layout

  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page.find(params[:id])
    if not @page.state?
      redirect_to group_path @page.group.permalink if current_user and not Member.find_by_profile_id current_user.profile.id
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new
    @page.author = current_user.profile.name || ""
    @url = group_pages_path
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
    @url = group_page_path @page.group_id, @page.id
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])

    @page.group_id = params[:group_id]
    @page.allow_comment=false
    @page.state= true
    respond_to do |format|
      if @page.save
        format.html { redirect_to manage_pages_groups_url @page.group.permalink, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @content }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to manage_pages_groups_url @page.group.permalink, notice: 'Page was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to manage_pages_groups_url @page.group.permalink }
      format.json { head :ok }
    end
  end
end
