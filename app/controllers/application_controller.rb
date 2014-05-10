class ApplicationController < ActionController::Base
  after_filter :user_activity

  private

  def user_activity
    current_user.try :touch
  end
end
