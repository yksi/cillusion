class FollowsController < ApplicationController
  
  def create 
    user = User.find(:id)
    current_user.follow!(user)
    redirect_to user
  end
  

  def destroy
    user = User.find(:id)
    current_user.unfollow!(user)
    redirect_to user
  end

  private

  def follow_params
    params.require(:article).permit(:follower_id, :followable_id)
  end
end