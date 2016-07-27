class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :destroy, :show]

  def index
    @friends = Friend.all
    @user = current_user
    @new_tweets = @user.tweets.new_sorted(params)
    @viewed_tweets = @user.tweets.viewed_sorted(params)
    refresh_tweets if Tweet.viewed_all?(current_user)
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
    tweet.update(viewed: true)
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

  def refresh_tweets
    Users::ImportTwitterAccountInformation.delay.run(user: current_user)
    flash[:notice] = "Hang tight! We are looking for new Tweets."
  end
end
