class MembersController < ApplicationController
  respond_to :json

  include GroupsHelper
  before_filter :group_permalink_to_id

  before_filter :require_login
  before_filter :permitted_group
  before_filter :require_admin, :except => [:join]
  before_filter :require_fulfill_profile, :only => [:join]

  def join
    @group = get_group params[:group_id]
    @member = Member.create! :authority => 1, :group_id => params[:group_id], :profile_id => current_user.profile.id, :is_audited => false

    render :json => { :result => @member.id > 0 }
  end

  def create

  end

  def destroy

  end

  def update

  end

end
