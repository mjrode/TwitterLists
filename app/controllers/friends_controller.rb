class FriendsController < ApplicationController
  def index
    @friends = current_user.friends.all
  end

  def all
    # @friends = current_user.unassigned_friends
    @friends = current_user.friends.all
  end
end
