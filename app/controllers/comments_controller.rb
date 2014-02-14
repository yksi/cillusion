class CommentsController < ApplicationController
  def index
  end

  def create
    @comment = current_user.comments.create(comment_params)
    redirect_to @comment.article
  end

  def new
    @comment = Comment.new
  end

  def show
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user, :article_id)
  end
end
