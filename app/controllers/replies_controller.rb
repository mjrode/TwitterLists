class RepliesController < ApplicationController
  def new
  end

  def create
    Replies::SendReply.run(
      message: params[:body],
      remote_tweet_id: params[:remote_tweet_id],
      tweet_id: params[:tweet_id],
      user: current_user
    )
    redirect_to :back
  rescue Twitter::Error => e
    flash[:notice] = "Unable to send reply due to #{e}"
    redirect_to :back
  end
end
