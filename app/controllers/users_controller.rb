class UsersController < ApplicationController
  before_action :find_user, only: [:update, :show, :edit, :follows, :followers]

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      set_flash_message :notice, :updated
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  def index
    @users = User.all
    @articles = Article.order(created_at: :desc)
    if user_signed_in?
      redirect_to browse_timeline_path
    end
  end


  def show
    @message = Message.new
		@user = User.find(params[:id])
		@articles = @user.user_articles.all
		@user_created_at = @user.created_at.strftime("%d %B %Y")
    @users = @user.followers
    @complete = 40
    if @user.hometown
      @complete += 20
    end
    if @user.age
      @complete += 20
    end
    if @user.avatar?
      @complete += 20
    end
	end

	def edit
		@user = User.find(params[:id])
	end

  def destroy
  end

  def follows
    @user = User.find(params[:id])
    current_user.follow(@user)
  end

  def followers
    @users = @user.followers
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
