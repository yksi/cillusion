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

  def get_article_image
    article = Article.find(params[:a])
    render text: article.photo.url
  end

  def get_followers
    email = params[:e]
    password = params[:p]
    user = User.find_by_email(email)
    if user && user.valid_password?(password)
      render json: user.followers
    else
      render text: 'access denieded'
    end
  end

  def get_all_users
    email = params[:e]
    password = params[:p]
    user = User.find_by_email(email)
    if user && user.valid_password?(password)
      render json: User.all
    else
      render text: 'access denieded'
    end
  end

  def get_user_articles
    email = params[:e]
    password = params[:p]
    user = User.find_by_email(email)
    reguest_user = User.find(params[:u])
    if user && user.valid_password?(password)
      render json: reguest_user.user_articles
    else
      render text: 'access denieded'
    end
  end

  def get_fullname
    if params[:u].present?
      render text: User.find(params[:u]).fullname
    else
      render text: 'Undefined'
    end
  end

  def get_article_comments
    email = params[:e]
    password = params[:p]
    user = User.find_by_email(email)
    article = Article.find(params[:a])
    if user && user.valid_password?(password)
      render json: article.comments
    else
      render text: 'access denieded'
    end
  end

  def get_user_avatar
    user = User.find(params[:u])
    version = params[:v]
    render text: user.avatar.url(check_version(version))
  end

  private

  def check_version version
    if version == "small"
      :small
    elsif version == "thumb"
      :thumb
    else
      nil
    end
  end
end