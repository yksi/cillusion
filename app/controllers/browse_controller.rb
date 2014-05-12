class BrowseController < ApplicationController
  before_action :find_articles
  before_action :find_users

  def index
    @comments = Comment.order(created_at: :desc)
  end

  def timeline
    current_user.read_news!
  end

  def articles
    @articles = Article.search(params[:search]).paginate(page: params[:page], per_page: 10)
  end

  def users
    @users = User.search(params[:search]).paginate(page: params[:page], per_page: 10)
  end

  private

  def find_articles
    @articles = Article.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def find_users
    @users = User.order(created_at: :desc)
  end

end
