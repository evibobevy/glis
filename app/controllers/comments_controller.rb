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
    @comment = @post.comments.create(comment_params)
    respond_to do |format|
      format.js
    end
    #redirect_to root_path
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter)
  end
end
