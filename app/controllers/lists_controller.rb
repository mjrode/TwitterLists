class ListsController < ApplicationController
before_action :set_list, only: [:view, :show, :destroy, :add_friends, :select_friends]

  def  index
    @friends = Friend.all
    @lists = current_user.lists.all
  end

  def new
    @list = List.new
  end

  def create
    @list = List.find_or_create_by(name: params[:list][:name], user_id: current_user.id)
    result = Lists::CreateRemoteList.run(local_list: @list, user: current_user)
    if result.success
      redirect_to select_friends_list_path(id: @list.id)
    else
      flash[:warning] = "That name has already been taken"
      redirect_to new_list_path
    end
  end

  def select_friends
    @friends = current_user.friends
  end

  def add_friends
    Lists::AddFriendsToLocalList.run(friends_hash: params[:friends], list: @list, user: current_user)
    Lists::AddFriendsToRemoteList.run(list: @list, user_id: current_user.id)
    flash[:notice] = "Check out your new list here #{@list.name}"
    redirect_to lists_path
  end

  def show
    @schedules = @list.on_list
  end

  def destroy
    Lists::DeleteList.run(list: @list, user: current_user)
    @list.destroy
    redirect_to lists_path
  end


  def import
    Lists::ImportLists.run(username: current_user.username)
    redirect_to lists_path
  end

  private

  def set_list
    @list = List.find(params[:id])
  end
end
