class BrowseController < ApplicationController

  def index
    @comments = Comment.order(created_at: :desc)
  end

  def timeline
    @logs = Log.order(created_at: :desc)
    respond_to do |format|
      format.html { current_user.read_news! }
      format.json { render text: current_user.has_new_logs? }
    end
  end

  def articles
    @articles = Article.search(params[:search]).order(created_at: :desc).paginate(page: params[:page], per_page: 9)
  end

  def users
    @users = User.search(params[:search]).order(updated_at: :desc).paginate(page: params[:page], per_page: 9)
  end

  def groups
    @groups = Group.search(params[:search]).order(created_at: :desc).paginate(page: params[:page], per_page: 9)
  end
end
