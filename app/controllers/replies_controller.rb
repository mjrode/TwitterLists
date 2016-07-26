class RepliesController < ApplicationController
  def new
  end

  def create
    result = Replies::SendReply.run(reply_params)
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render json: result.to_json }
      format.js { render text: 'ajax done' }
    end
  rescue Twitter::Error => e
    flash[:notice] = "Unable to send reply due to #{e}"
  end

  private

  def reply_params
    {
      message: params[:body],
      remote_tweet_id: params[:remote_tweet_id],
      tweet_id: params[:tweet_id],
      user: current_user
    }
  end
end
