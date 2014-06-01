class ArticlesController < ApplicationController
  before_action :require_article, only: [:show, :edit, :destroy, :update, :share_via_message]
  before_action :require_category, only: [:index, :edit, :new]
  before_action :can_submit, only: [:new, :edit]

  def index
  	@articles = current_user.user_articles.all
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
  end

  def create
  	@article = current_user.user_articles.create(article_params)
  	if @article.save
      @article.track_log(current_user)
      redirect_to @article
    else
      redirect_to :back, alert: "Theme and article content cannot be blank."
    end
  end

  def new
  	@article = current_user.user_articles.new
  end

  def show
    if user_signed_in? && !current_user.view?(@article) && @article.user != current_user
      view = current_user.view!(@article)
      view.track_log(current_user.id)
    end
    @status = 1
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
    @article.reverse_logs
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

  def share_via_message
    current_user.sent_messages.create!(theme: @article.theme, content: "#{current_user.first_name} shared article <br><a href='#{article_path(@article)}'>#{@article.theme}</a> to you", recipient_id: params[:user_id])
    respond_to do |format|
      format.js { render json: :success }
    end
  end

  private

  def article_params
  	params.require(:article).permit(:content, :date, :user_id, :theme, :category, :photo, :group_id)
  end

  def article_params_to_update
    params.require(:article).permit(:content, :date, :user_id, :theme, :category, :photo, :group_id)
  end

  def require_article
    @article = Article.find(params[:id])
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


