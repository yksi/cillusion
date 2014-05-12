class CommentsController < ApplicationController
  def index
  end

  def create
    @comment = current_user.comments.create(comment_params)
    @comment.track_log(current_user.id) if current_user != @comment.user
    redirect_to @comment.article
    if @comment.content.length >= 255
      flash[:alert] = "Comment size is too large"
    elsif @comment.content.length < 1
      flash[:alert] = "Comment is empty"
    end
  end

  def new
    @comment = Comment.new
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.reverse_logs
    @comment.destroy
    redirect_to @comment.article
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user, :article_id)
  end
end
