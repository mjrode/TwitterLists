class SessionsController < ApplicationController
  def create
    response = Users::UserAuthenticationFromOauth.run(auth_hash: request.env["omniauth.auth"])
    @user = response.user
    Users::ListOfFriends.run(user: @user)
    redirect_to root_path
  end

  def destroy
  end
end
