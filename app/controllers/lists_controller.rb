class ListsController < ApplicationController

  def  index
    @friends = Friend.all
  end

  def name
    @lists = List.new
  end

  def create
    List.create!(
      name = params[:name])
  end

  def new
  end

  def create
  end
end
