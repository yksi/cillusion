class ArticlesController < ApplicationController

  before_action :require_article, only: [:show, :edit, :destroy, :update]
  before_action :require_category, only: [:index, :edit, :new] 

  def index
  	@articles = current_user.user_articles.all
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
  end

  def create
  	@article = current_user.user_articles.create(article_params)
  	if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def new
  	@article = current_user.user_articles.new
  end

  def show
    @comments = @article.comments.all
    @comment = Comment.new
    @me = current_user == @article.user
  end

  def edit
  end

  def destroy
  	@article.destroy
  	redirect_to root_path
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def search
    @articles = Article.search(params[:search])
  end

  private

  def article_params
  	params.require(:article).permit(:content, :date, :user_id, :theme, :category)
  end

  def require_article
    @article = Article.find(params[:id])
  end

  def require_category
    @category = ["Programming", "News", "Wiki", "How To", "My Life", "Science", "Math", "Other"] 
  end

end


