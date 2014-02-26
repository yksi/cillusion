class UsersController < ApplicationController

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
  end


  def show
		@user = User.find(params[:id])
		@articles = @user.user_articles.all
		@user_created_at = @user.created_at.strftime("%d %B %Y")    
	end

	def edit
		@user = User.find(params[:id])
	end

  def destroy 	
  end 

  
end
