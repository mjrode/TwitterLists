class FriendsController < ApplicationController
  def index
    @friends = Friend.all
  end

  def all
    # @friends = current_user.unassigned_friends
    @friends = Friend.all
  end
end
