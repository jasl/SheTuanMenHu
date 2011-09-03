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
      store_location
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
end
