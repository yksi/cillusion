class ApiController < ApplicationController
  def get_user
    email = params[:e]
    password = params[:p]
    user = User.find_by_email(email)
    if user && user.valid_password?(password)
      render text: "success\n#{user.fullname}"
    else
      render text: 'Invalid email or password'
    end
  end

  def get_my_articles
    if User.find_by_email(params[:e]).valid_password?(params[:p])
      render json: User.find_by_email(params[:e]).user_articles
    else
      render text: 'access denieded'
    end
  end
end