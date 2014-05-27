class CommentsController < ApplicationController
  def index
  end

  def create
    @comment = current_user.comments.create(comment_params)
    @comment.track_log(current_user.id) if current_user != @comment.article.user
    if @comment.save
      respond_to do |format|
        format.html { redirect_to :back, notice: "Your comment is posted!" }
        format.js
      end
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
    respond_to do |format|
      format.html { redirect_to :back, notice: "Comment is deleted!" }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user, :article_id)
  end
end
