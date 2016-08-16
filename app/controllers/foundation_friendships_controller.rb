class FoundationFriendshipsController < ApplicationController
  before_filter :authorize, only: :user_support

  def user_support
    if params[:friend_id].present?
      @friend_id = params[:friend_id]
      @friendship = current_user.foundation_friendships.build(:friend_id => params[:friend_id].to_i, :accepted => 'pending')
      @user = User.find(params[:friend_id])
      if @friendship.save
        UserMailer.user_notification(@user,@friend_id).deliver!  if @user.email_notification
        flash.now[:notice] = "Added friend."
      else
        flash[:error] = "Error occur when adding friend."
      end
      redirect_to :back and return
    end
  end

  def user_unsupport
    if current_user.foundation_friendships.find_by_friend_id(params[:friend_id]).present?
      @friendship = current_user.foundation_friendships.find_by_friend_id(params[:friend_id])
      @friendship.destroy
      flash[:notice] = "Successfully destroyed friendship."
      redirect_to :back and return
    end
  end

  def spread_user_post
    if params[:post_id ].present?
      post = Post.find(params[:post_id])
      @post = current_user.posts.build(:name=> post.name)
      if @post.save
        flash[:notice] = "Shared post."
        redirect_to :back and return
      else
        flash[:error] = "Error occur when adding friend."
        redirect_to :back and return
      end
    end
  end

  def authorize
    unless user_signed_in?
      redirect_to root_path
    end
  end

end
