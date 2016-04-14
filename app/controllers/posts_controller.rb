class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_filter :authorize, only: [:new, :create]
  respond_to :html

  def authorize
    unless user_signed_in?
      redirect_to new_user_registration_path
    end
  end

  def index
    @posts = Post.all
    respond_with(@posts)
  end

  def show
    respond_with(@post)
  end

  def new
    @post = Post.new
    respond_with(@post)
  end

  def edit
  end

  def create
    @event = Event.find(params[:event_id])
    @post = @event.posts.new(post_params)
    @post.user_id = current_user.id
     if @post.save
      redirect_to root_path
     else
       redirect_to :back
     end
  end

  def update
    @post.update(post_params)
    respond_with(@post)
  end

  def destroy
    @post.destroy
    respond_with(@post)
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:name, :user_id, :event_id)
    end
end
