class ArticlesController < ApplicationController

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
	@article = Article.find(params[:id])
end



def edit
	@article = Article.find(params[:id])	
end

def destroy
	@article = Article.find(params[:id])
	@article.destroy
  UserMailer.welcome_email(User.find(@article.user_id)).deliver
	redirect_to root_path
end

def update
  @article = Article.find(params[:id])
 
  if @article.update(article_params)
    redirect_to @article
  else
    render 'edit'
  end
end

private

def article_params
	params.require(:article).permit(:content, :date, :user_id, :theme)
end
end


