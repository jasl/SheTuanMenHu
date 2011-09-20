class UserSessionsController < ApplicationController
   before_filter :require_not_login, :only => :create
   before_filter :require_login, :only => :destroy

   def new
    @user_session = UserSession.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_session }
    end
   end

   def create
    @user_session = UserSession.new(params[:user_session])

    respond_to do |format|
      if @user_session.save
        @login_info = { :last_login_ip => request.remote_ip, :last_login_at => Time.now }
        UserSession.find.record.update_attributes @login_info
        format.html { redirect_back_or root_path }
        format.json  { render :xml => @user_session, :status => :created, :location => root_path }
      else
        format.html { render :new}
        format.json  { render :xml => @user_session.errors, :status => :unprocessable_entity }
      end
    end
   end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy

    respond_to do |format|
      format.html { redirect_to root_path, :notice => "You have already log outed" }
      format.json  { head :ok }
    end
  end

end
