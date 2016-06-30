class FriendsController < ApplicationController
  def index
    @user = current_user
    @friends = current_user.friends.all
  end

  def all
    @friends = current_user.friends.all
  end
end
