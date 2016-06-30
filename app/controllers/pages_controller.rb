class PagesController < ApplicationController
  skip_before_action :authenticate

  def home
    @user = current_user
    if current_user
      @email_text = "Add Email Address" if current_user.email.nil?
      @email_text = "Edit Email Address" if current_user.email.present?
    end
  end

  def find_list
    @list = List.find(params[:list])
    redirect_to edit_list_path(@list)
  end
end
