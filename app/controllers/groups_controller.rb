class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
    @articles = current_user.user_articles if user_signed_in?
    @list = 0
  end

  def create
    @group = current_user.groups.create(group_params)
    if @group.save
      redirect_to @group, notice: "Group '#{@group.name}' was succesfully created"
    else
      redirect_to :back, alert: "Group cannot to be saved. Please try again."
    end
  end

  def add_article_to
    if params[:article]
      if @article = Article.find(params[:article]).update_columns(group_id: params[:id])
        flash[:notice] = "Successfully added..."
      end
    end
    redirect_to Group.find(params[:id])
  end

  def delete_article_from
    if params[:article]
      if @article = Article.find(params[:article]).update_columns(group_id: nil)
        flash[:notice] = "Successfully removed..."
      end
    end
    redirect_to Group.find(params[:id])
  end

  def update
  end

  def destroy
    @group = Group.find(params[:id])
    Article.where(group_id: @group.id).each do |article|
      article.update_column(:group_id, nil)
    end
    @group.destroy
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end

end