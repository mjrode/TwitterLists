class PagesController < ApplicationController
  def home
    @email_text = "Add Email Address" if current_user.email.nil?
    @email_text = "Edit Email Address" if current_user.email.present?
  end
end
