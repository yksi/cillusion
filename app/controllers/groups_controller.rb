class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
    @articles = current_user.user_articles
    @list = 0
  end

  def create
    @group = current_user.groups.create(group_params)
    if @group.save
      redirect_to @group, notice: "Group '#{@group.name} was succesfully created'"
    else
      redirect_to :back, alert: "Group cannot to be saved. Please try again."
    end
  end

  def add_article_to
    if params[:article]
      @group = Group.find(params[:id])
      if @article = Article.find(params[:article]).update_columns(group_id: params[:id])
        @group.update_column(:article_count, @group.article_count+1)
        flash[:notice] = "Successfully added..."
      end
    end
    redirect_to Group.find(params[:id])
  end

  def delete_article_from
    if params[:article]
      @group = Group.find(params[:id])
      if @article = Article.find(params[:article]).update_columns(group_id: nil)
        @group.update_column(:article_count, @group.article_count-1)
        flash[:notice] = "Successfully removed..."
      end
    end
    redirect_to Group.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end

end