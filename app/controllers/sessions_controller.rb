class SessionsController < ApplicationController
  def create
    response = Users::UserAuthenticationFromOauth.run(auth_hash: request.env["omniauth.auth"])
    redirect_to root_path
  end

  def destroy
  end
end
