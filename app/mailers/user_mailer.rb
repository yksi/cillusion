class UserMailer < ActionMailer::Base
  default from: 'mailer778@gmail.com'

  def welcome_email(user_id)
    @user = User.find(user_id)
    mail to: @user.email, subject: 'New and Improved Helpified Features'
  end

end
