class ProfilesController < ApplicationController
  # GET /profiles
  # GET /profiles.json
  def index
    @profile = current_user.profile

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @profile }
    end
  end

=begin
  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @profile = Profile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @profile }
    end
  end
=end

  # GET /profiles/new
  # GET /profiles/new.json
  def new
    @profile = Profile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @profile }
    end
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(params[:profile])
    @profile.email = current_user.email
    @profile.build_user && @profile.user = current_user

    respond_to do |format|
      if @profile.save
        format.html { redirect_to root_path, notice: 'Profile was successfully created.' }
        format.json { render json: @profile, status: :created, location: @profile }
      else
        format.html { render action: "new" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.json
  def update
    @profile = Profile.find(params[:id])

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to profiles_path, notice: 'Profile was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "index" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

end
