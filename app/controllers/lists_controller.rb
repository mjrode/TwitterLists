class ListsController < ApplicationController
  before_action :set_list, only: [:view, :show, :destroy, :add_friends, :select_friends]

  def index
    @friends = Friend.all
    @lists = current_user.lists.all
  end

  def new
    @list = List.new
  end

  def create
    result = Lists::CreateList.run(create_list_params)
    if result.success
      redirect_to select_friends_list_path(id: result.local_list.id)
    else
      flash[:warning] = "That name has already been taken"
      redirect_to edit_list_path(result.local_list)
    end
  end

  def select_friends
    @friends = current_user.friends
  end

  def add_friends
    result = Lists::AddFriends.run(add_friends_params)
    flash[:notice] = result.message
    redirect_to root_path
  end

  def show
    @schedules = @list.on_list
  end

  def add_multiple_friends
    Lists::AddFriendsToMultipleLists.run(friends_hash: params["friends"], user: current_user)
    redirect_to root_path
  end

  def edit
    @list = current_user.lists.find(params[:id])
    @friends = current_user.friends
    @user = current_user
  end

  def destroy
    Lists::DeleteList.run(list: @list, user: current_user)
    @list.destroy
    redirect_to root_path
  end

  def import
    # Need to rate limit this call
    Users::ImportTwitterAccountInformation.run(user: current_user)
    Lists::UpdateLocalLists.run(user: current_user)
    flash[:success] = "Your lists have been updated!"
    redirect_to root_path
  end

  def viewed
  end

  private

  def set_list
    @list = current_user.lists.find(params[:id])
  end

  def create_list_params
    {
      name: params[:list][:name].strip,
      days_until_rotation: params[:list][:days_until_rotation],
      user: current_user
    }
  end

  def add_friends_params
    {
      friends_hash: params[:friends],
      
      list: @list,
      user: current_user, 
      days_between_rotation: params[:days_between_rotation].to_i
    }
  end
end
