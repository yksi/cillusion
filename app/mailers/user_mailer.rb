class UserMailer < ActionMailer::Base
  default from: "cillusiion@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://cillusion.herokuapp.com'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  
end
