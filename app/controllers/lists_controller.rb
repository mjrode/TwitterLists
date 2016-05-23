class ListsController < ApplicationController

  def  index
    @friends = Friend.all
    @lists = current_user.lists
  end

  def create
    @list = List.find_or_create_by!(name: params[:list][:name])
    redirect_to view_friends_list_path(id: @list.id)
  end

  def view_friends
    @list = List.find(params[:id])
    @friends = current_user.friends
  end

  def add_friends
    @list = List.find(params[:list])
    Lists::AddFriendsToList.run(friend_ids: params[:friend_ids], list: @list, user: current_user)
  end

  def new
    @list = List.new
  end
end
