class SessionsController < ApplicationController
  def create
    response = Users::UserAuthenticationFromOauth.run(auth_hash: request.env["omniauth.auth"])
    @user = response.user
    session[:user_id] = @user.id
    flash[:success] = response.message
    redirect_to pages_home_path
  end
  
  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = 'See you!'
    end
    redirect_to root_path
  end
end
