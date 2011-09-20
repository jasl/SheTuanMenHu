module ApplicationHelper
  #AuthLogic
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_session && current_session.record
  end

  def current_session
    return @current_session if defined?(@current_session)
    @current_session = UserSession.find
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def require_login
    if not current_user
      #store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to login_path
    end
  end

  def require_not_login
	redirect_to root_path if current_user
  end

  def require_fulfill_profile
    defined?UserSession.find.profile
  end

  def redirect_back_or(path)
    redirect_to session[:return_to] || path
    clear_return_to
  end

  def clear_return_to
    session[:return_to] = nil
  end

  def empty_or_nil_field?(obj)
    !defined?obj or obj.blank?
  end

  #check authority
  def require_publisher
    @id = params[:group_id] || params[:id]
    if @id.to_i != 0
      @member = Member.where("profile_id = ? and group_id = ?", current_user.profile.id, @id).first
    else
      @group_id = Group.select(:id).where(:permalink => @id).first
      @member = Member.where("profile_id = ? and group_id = ?", current_user.profile.id, @group_id).first
    end

    if @member.nil? || @member.authority < 2
      flash[:notice] = "You can not access this page."
      redirect_to root_path
    end
  end

  def require_admin
    @id = params[:group_id] || params[:id]
    if @id.to_i != 0
      @member = Member.where("profile_id = ? and group_id = ?", current_user.profile.id, @id).first
    else
      @group_id = Group.select(:id).where(:permalink => @id).first
      @member = Member.where("profile_id = ? and group_id = ?", current_user.profile.id, @group_id).first
    end

    if @member.nil? || @member.authority < 3
      flash[:notice] = "You can not access this page."
      redirect_to root_path
    end

  end

  def permitted_group
    @id = params[:group_id] || params[:id]
    if @id.to_i != 0
      @group_audit = Group.select(:is_audited).find(@id)
    else
      @group_audit = Group.select(:is_audited).where(:permalink => @id).first
    end

    if not @group_audit.is_audited?
      flash[:notice] = "The Group need audit."
      redirect_to root_path
    end
  end

  def get_group key
    if params[:id].to_i != 0
      @group = Group.find(params[:id])
    else
      @group = Group.where(:permalink => params[:id]).first
    end
    @group || nil
  end

  def group_id_to_permalink
    params[:group_id] = Group.select(:permalink).find params[:group_id] if params[:group_id] && params[:group_id].to_i != 0
  end
end
