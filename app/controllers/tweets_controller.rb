class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :destroy, :show]
  # skip_before_action :verify_authenticity_token


  def index
    @friends = Friend.all
    @user = current_user
    @tweets = @user.sort(params)
  end

  def new
  end

  def share
    result = Tweets::ShareApp.run(
      message: params[:body],
      user: current_user
    )
    respond_to do |format|
      format.json  { render json: result.to_json }
    end
  end

  def fetch
    Users::ImportTwitterAccountInformation.delay.run(user: current_user)
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

  def seen
    tweet = Tweet.find_by_remote_tweet_id(params[:id])
    tweet.viewed = true 
    tweet.save
    respond_to do |format|
      format.json  { head :no_content }
    end
  end

  private

  def set_tweet
    @tweet = Tweet.find_by(id: params[:id])
  end

  def authenticate
    redirect_to root_path unless current_user
  end
end
