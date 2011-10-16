class UsersController < ApplicationController
  before_filter :require_login, :except => [:new, :create]

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/
  def index
    @user = current_user
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user }
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save and Profile.create! :user_id => @user.id, :email => @user.email
        format.html { redirect_to root_path, notice: 'Registration successfully.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = current_user
    params[:user].delete :email if not empty_or_nil_field?@user.email
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to root_path, notice: 'Password was successfully modified.' }
        format.json { head :ok }
      else
        format.html { render action: "index" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end
