class BrowseController < ApplicationController

  def index
    @comments = Comment.order(created_at: :desc)
  end


  def timeline
    @logs = Log.order(created_at: :desc)
    current_user.read_news!
  end

  def articles
    @articles = Article.search(params[:search]).paginate(page: params[:page], per_page: 9)
  end

  def users
    @users = User.search(params[:search]).paginate(page: params[:page], per_page: 9)
  end

end
