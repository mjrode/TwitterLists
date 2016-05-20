class ListsController < ApplicationController

  def  index
    @friends = Friend.all
    @lists = current_user.lists
  end

  def name
    @list = List.new
  end

  def create
    @list = List.find_or_create_by(name: params[:list][:name])
    redirect_to add_friends_list_path(id: @list.id)
  end

  def add_friends
    @friends = current_user.friends
    binding.pry
  end

  def new
    @list = List.new
  end
end
