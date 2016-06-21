class FriendsController < ApplicationController
  before_action :authenticate
  def index
    @user = current_user
    @friends = current_user.friends.all
  end

  def all
    @friends = current_user.friends.all
  end

  private

  def authenticate
    redirect_to root_path unless current_user
  end
end
