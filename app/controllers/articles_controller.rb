class ArticlesController < ApplicationController
  before_action :require_article, only: [:show, :edit, :destroy, :update]
  before_action :require_category, only: [:index, :edit, :new]
  before_action :can_submit, only: [:new, :edit]

  def index
  	@articles = current_user.user_articles.all
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
  end

  def create
  	@article = current_user.user_articles.create(article_params)
  	if @article.save
      redirect_to @article
    else
      render :new, alert: "Please fill in all required fields."
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
    if !user_signed_in? || @article.user!= current_user
      redirect_to @article
    end
  end

  def destroy
  	@article.destroy
  	redirect_to current_user
  end

  def update
    if @article.update(article_params_to_update)
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
  	params.require(:article).permit(:content, :date, :user_id, :theme, :category, :photo)
  end

  def article_params_to_update
    params.require(:article).permit(:content, :date, :user_id, :theme, :category, :photo, :group_id)
  end

  def require_article
    @article = Article.find_by_theme(params[:id]) || Article.find(params[:id].split('_')[1])
  end

  def require_category
    @category = ["Programming", "Business", "Traveling", "Languages", "Cars", "Technologies", "Gaming", "Films", "Music", "Poetry", "News", "Wiki", "How To", "My Lifestyle", "Science", "Math", "Other"]
  end

  def can_submit
    if @article.present? && @article.theme.present? && @article.theme.length >= 2
      @can = true
    else
      @can = false
    end
  end

end


