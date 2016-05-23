class ListsController < ApplicationController
  before_action :set_list, only: [:view_friends, :view, :show, :destroy]

  def  index
    @friends = Friend.all
    @lists = current_user.lists.all
  end

  def create
    @list = List.find_or_create_by!(name: params[:list][:name], user_id: current_user.id)
    if @list.new_list?(current_user)
      redirect_to view_friends_list_path(id: @list.id)
    else
      flash[:warning] = "That name has already been taken"
      redirect_to new_list_path
    end
  end

  def view_friends
    @friends = current_user.friends
  end

  def add_friends
    Lists::AddFriendsToList.run(friends_hash: params[:friends], list: @list, user: current_user)
    redirect_to view_list_path(@list)
  end

  def view
    @schedules = @list.on_list
    @user = current_user
    # need to check if list already exists and then add to that list
    if @list.new_list?(@user)
      Lists::SendListToTwitter.run(list: @list, user_id: @user.id)
      flash[:notice] = "Check out your new list here #{@list.name}"
      redirect_to root_path
    else
      redirect_to root_path
      flash[:warning] = "Please choose a different name."
    end
  end

  def show
    @schedules = @list.on_list
  end

  def destroy
    @list.destroy
    redirect_to lists_path
  end

  def new
    @list = List.new
  end

  private

  def set_list
    @list = List.find(params[:id])
  end
end
