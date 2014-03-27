class BrowseController < ApplicationController
  before_action :find_articles
  before_action :find_users

  def index
    @comments = Comment.order(created_at: :desc)
  end

  def timeline
      @new_articles = []
      current_user.followed_users.each do |f|
        f.user_articles.each do |a|
          @new_articles << a
        end
      end
      @resourses = []

      Relationship.all[0..100].each do |relationship|
        @resourses << relationship
      end

      User.all[0..10].each do |user|
        @resourses << user
      end

      @new_articles[0..50].each do |new_article|
        @resourses << new_article
      end

      @resourses = @resourses.sort_by { |a|  a.created_at }.reverse
  end

  private

  def find_articles
    @articles = Article.order(created_at: :desc).paginate(page: params[:page], per_page: 20)
  end

  def find_users
    @users = User.order(created_at: :desc)
  end

end
