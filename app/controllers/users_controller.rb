class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :follows, :followers, :follow, :unfollow]

  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(user_params)
    end
    redirect_to root_path
  end

  def index
    @users = User.all
    @articles = Article.order(created_at: :desc)
    if user_signed_in?
      redirect_to current_user
    end
  end


  def show
    @message = Message.new
		@articles = @user.user_articles.all
		@user_created_at = @user.created_at.strftime("%d %B %Y")
    @followers = @user.followers
    @followed = @user.followed_users
    @complete = 20
    if @user.hometown
      @complete += 20
    end
    if @user.born_date
      @complete += 20
    end
    if @user.avatar?
      @complete += 20
    end
    if @user.about
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

  def follow
    rel = current_user.follow!(@user)
    rel.track_log(current_user)
    respond_to do |format|
      format.js { render json: { success: true }  }
    end
  end

  def unfollow
    rel = current_user.unfollow!(@user)
    rel.reverse_logs
    respond_to do |format|
      format.js { render json: { success: true }  }
    end
  end

  private

  def find_user
    get_params = params[:id].split('_')
    p get_params
    @user = (get_params.length > 2) ? User.find(get_params[2]) : User.find(:first, conditions: ["lower(first_name) LIKE ? ", get_params[0].downcase.mb_chars.downcase.to_s], conditions: ["lower(last_name) LIKE ? ", get_params[1].downcase.mb_chars.downcase.to_s] )
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :avatar, :avatar_cache, :age, :sex, :hometown, :email, :password, :pasword_confirmation, :paused)
  end
end
