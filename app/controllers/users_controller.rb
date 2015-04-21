class UsersController < ApplicationController
  def signup
  	@user = User.new
  end

  def create
  	@user = User.new(u_params)
  	if @user.save
      cookies[:auth_token] = @user.auth_token
  	  redirect_to :root
    else
      render :signup
    end
  end


def create_login_session
  user = User.find_by_name(params[:name])
  if user && user.authenticate(params[:password])
    #session[:user_id] = user.id
    if params[:remember_me]
      cookies.permanent[:auth_token] = user.auth_token
    else
      cookies[:auth_token] = user.auth_token
    end
    flash.notice = "login.success"
    redirect_to :root
  else
    flash.notice = "login.faild"
    redirect_to :login
  end
end

def logout
  #session[:user_id] = nil
  cookies.delete(:auth_token)
  redirect_to :root
end

  private
    def u_params
    	params.require(:user).permit!
    end
end
