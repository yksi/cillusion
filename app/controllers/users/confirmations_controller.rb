class Users::ConfirmationsController < Devise::ConfirmationsController

  protected

  def after_sending_confirmation_instructions_path_for
    @sum_notice = "Profile was crated, Check your email and follow link to login."
    new_user_session_path
  end
end