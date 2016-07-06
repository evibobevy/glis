class CommentsController < ApplicationController
  before_filter :authorize, only: [:new, :create]
  respond_to :html

  def authorize
    unless user_signed_in?
      redirect_to new_user_registration_path
    end
  end

  def new
    @comment = Comment.new
  end
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id if user_signed_in?
    @comment.save
    respond_to do |format|
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :user_id)
  end
end
