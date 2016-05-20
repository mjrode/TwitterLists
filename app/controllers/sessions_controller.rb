class SessionsController < ApplicationController
  def create
    response = Users::UserAuthenticationFromOauth.run(auth_hash: request.env["omniauth.auth"])
    @user = response.user
    session[:user_id] = @user.id
    flash[:success] = response.message
    redirect_to pages_home_path
  end

  def destroy
  end
end
