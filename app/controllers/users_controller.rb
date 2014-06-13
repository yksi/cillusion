class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :follows, :follow, :unfollow, :followers, :followed]

  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(user_params)
    end
    redirect_to root_path
  end

  def unique
    uid = params[:uid]
    respond_to do |format|
      if User.find_by_uid(uid).nil?
        format.js { render text: "avialible" }
      else
        format.js { render text: "already taken" }
      end
    end
  end

  def index
    @users = User.all
    @articles = Article.order(created_at: :desc)
    if user_signed_in?
      redirect_to current_user
    end
  end


  def show
    I18n.locale = current_user.prefer_lang if user_signed_in?
    @message = Message.new
		@articles = @user.user_articles.order(created_at: :desc).paginate(page: params[:page], per_page: 9)
		@user_created_at = @user.created_at.strftime("%d %B %Y")
    @followers = @user.followers
    @followed = @user.followed_users
    @complete = 20
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
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

  def followers
    @followers = @user.followers
    if @followers.any?
      render json: { html: render_to_string(partial: "users/followers", formats: [:html]) }
    end
  end

  def followed
    @followed = @user.followed_users
    if @followed.any?
      render json: { html: render_to_string(partial: "users/followed", formats: [:html]) }
    end
  end

  private

  def find_user
    if User.find_by_uid(params[:id])
      @user = User.find_by_uid(params[:id])
    else
      @user = User.find(params[:id].split('id')[1])
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :avatar, :avatar_cache, :age, :sex, :hometown, :email, :password, :pasword_confirmation, :paused, :prefer_lang, :uid)
  end
end
