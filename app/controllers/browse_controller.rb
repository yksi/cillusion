class BrowseController < ApplicationController
  before_action :find_articles, except: [:users]
  before_action :find_users, except: [:articles]

  def index
    @comments = Comment.order(created_at: :desc)
  end

  def users
  end

  def articles
  end

  def statistic
    @comments = Comment.order(created_at: :desc)
  end

  private

  def find_articles
    @articles = Article.order(created_at: :desc)
  end

  def find_users
    @users = User.order(created_at: :desc)
  end

end
