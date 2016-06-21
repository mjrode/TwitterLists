class RepliesController < ApplicationController
  def new
  end

  def create
    Replies::SendReply.run(
      message: params[:body],
      remote_tweet_id: params[:status_id],
      user_id: params[:user_id],
      tweet_id: params[:tweet_id]
    )
    redirect_to :back
  end
end
