module UsersHelper
  
  def follow
    
    
  end

  def unfollow
    @user = User.find(params[:id])
    
  end

  
end
