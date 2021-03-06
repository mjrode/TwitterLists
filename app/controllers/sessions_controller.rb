class SessionsController < ApplicationController
  skip_before_action :authenticate
  def create
    response = Users::UserAuthenticationFromOauth.run(auth_hash: request.env["omniauth.auth"])
    @user = response.user
    session[:user_id] = @user.id
    flash[:success] = response.message
    respond_to do |format|
      format.html { redirect }
      format.js
    end
  end

  def set_email
    @user = current_user
  end

  def update_email
    current_user.email = params[:email]
    current_user.save
    redirect_to root_path
  end

  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = 'See you!'
    end
    redirect_to root_path
  end

  private

  def redirect
    redirect_to '/sessions/set_email' if @user.email.nil?
    redirect_to pages_home_path unless @user.email.nil?
  end
end
