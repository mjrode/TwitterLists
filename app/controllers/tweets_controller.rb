class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :destroy, :show]
  before_action :authenticate

  def index
    @friends = Friend.all
    @user = current_user
    @tweets = @user.sort(params)
  end

  def new
  end

  def fetch
    Users::ImportUsersFriends.delay.run(user: current_user)
    redirect_to tweets_path
  end

  def show
  end

  def edit
  end

  def destroy
    @tweet.destroy
    redirect_to tweets_path
  end

  private

  def set_tweet
    @tweet = Tweet.find_by(id: params[:id])
  end

  def authenticate
    redirect_to root_path unless current_user
  end
end
