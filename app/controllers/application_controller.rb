class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def loaded?
    if @current_user.tweets.count > 10 && @current_user.friends.count > 5 && @current_user.lists.count > 0
      true
    else
      false
    end
  end

  helper_method :current_user, :loaded?

  private

  def authenticate
    redirect_to root_path unless current_user
  end
end
