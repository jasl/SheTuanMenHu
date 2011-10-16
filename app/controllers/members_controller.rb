class MembersController < ApplicationController
  #respond_to :json

  include GroupsHelper
  before_filter :group_permalink_to_id

  before_filter :require_login
  before_filter :permitted_group
  before_filter :require_admin, :except => [:join]
  before_filter :require_fulfill_profile, :only => [:join]

  def join
    @group = get_group params[:group_id]

    if not Member.where(:group_id => params[:group_id], :profile_id => current_user.profile.id ).first.nil?
       render :json => { :result =>  false }
    elsif Member.create! :authority => '0', :group_id => params[:group_id], :profile_id => current_user.profile.id
       render :json => { :result =>  true }
    else
       render :json => { :result =>  false }
    end
  end

  def modify
    params[:members].each do |member_id, value|
      Member.find(member_id).update_attributes! value
    end
    render :json => { :result => true }
  end

  def create
    @profile_id = Profile.select(:id).where( :email => params[:member][:email]).first.id
    if @profile_id.nil? || Member.where(:group_id => params[:group_id], :profile_id => @profile_id).exists?
      @notice = 'Add unsuccessfully'
    elsif  Member.create! :profile_id => @profile_id, :group_id => params[:group_id], :authority => params[:member][:authority]
      @notice = 'Add successfully'
    else
      @notice = 'Add unsuccessfully'
    end
    redirect_to new_group_member_path(params[:permalink]), :notice => @notice
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to manage_control_groups_url(params[:permalink])
  end

  def update

  end

end
