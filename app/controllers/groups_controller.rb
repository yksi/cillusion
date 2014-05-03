class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.create(group_params)
  end

  def update
  end

  def destroy
  end

  private

  def group_params
    params.require(:group).permit(:name, :desctiption)
  end

end