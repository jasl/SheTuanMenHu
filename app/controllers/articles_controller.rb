class ArticlesController < ApplicationController
  before_filter :require_login, :except => [:show, :index]
  before_filter :permitted_group
  before_filter :require_publisher, :except => [:show, :index]

  include GroupsHelper
  before_filter :group_permalink_to_id
  before_filter :set_group_template, :only => [:index, :show]
  layout :theme_layout

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.where(:state => true, :group_id => @group.id).page(params[:page]).order('created_at DESC').to_a

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contents }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])

    if @article.nil? or not @article.state? or @article.group.id != @group.id
      redirect_to group_path @group.permalink if not (current_user && Member.find_by_profile_id(current_user.profile.id))
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new
    @article.author = current_user.profile.name || ""
    @url = group_articles_path
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
    @url = group_article_path @article.group_id, @article
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])

    @article.group_id = params[:group_id]
    @article.state= true

    respond_to do |format|
      if @article.save
        format.html { redirect_to manage_articles_groups_url @article.group.permalink, notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to manage_articles_groups_url @article.group.permalink, notice: 'Article was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])

    if @article.group.id == params[:group_id]
      @article.destroy
      respond_to do |format|
        format.html { redirect_to manage_articles_groups_url @article.group.permalink  }
        format.json { head :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path   }
        format.json { head :method_not_allowed }
      end
    end

  end
end
