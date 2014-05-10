class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)
    if @user.save
      sign_up(:user, @user)
      redirect_to @user
    else
      render :new
    end
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(user_params)
      set_flash_message :notice, :updated
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  def edit
    super
  end


  def show
    super
  end

  def destroy
    @user = User.find(current_user.id)
    @user.destroy
    redirect_to root_path, notice: "You successfully removed your profile"

    @user.sent_messages.each do |message|
      message.destroy
    end

    @user.recieved_messages.each do |message|
      message.destroy
    end

    @user.relationships.each do |relationship|
      relationship.destroy
    end

    @user.reverse_relationships.each do |relationship|
      relationship.destroy
    end

    @user.user_articles.each do |article|
      article.destroy
    end

    @user.comments.each do |comment|
      comment.destroy
    end

    @user.groups.each do |group|
      group.destroy
    end

  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :avatar, :avatar_cache, :last_name, :age, :sex, :hometown, :email, :password, :pasword_confirmation) }
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :avatar, :avatar_cache, :born_date, :sex, :hometown, :email, :password, :pasword_confirmation, :paused, :about)
  end

end