class DashboardController < ApplicationController
  layout 'dashboard'
	def index
		if !current_user.is_admin?
			redirect_to root_path
		end

    @logsTotal = Log.count
    @usersTotal = User.count
    @articlesTotal = Article.count
    @groupsTotal = Group.count

	end
end
