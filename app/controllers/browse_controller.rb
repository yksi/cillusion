class BrowseController < ApplicationController
  before_action :find_articles, except: [:users]
  before_action :find_users, except: [:articles]

  def index
  end

  def users
  end

  def articles
  end

  def statistic
    @comments = Comment.all
  end

  private

  def find_articles
    @articles = Article.all
  end

  def find_users
    @users = User.all
  end

end
