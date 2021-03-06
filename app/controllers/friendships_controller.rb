class FriendshipsController < ApplicationController
  before_filter :authorize, only: [:support]

  def support
    if params[:friend_id].present?
      @friend_id  = params[:friend_id] 
      @friendship = current_user.friendships.build(:friend_id => params[:friend_id].to_i, :accepted => 'approved')
      @user       = User.find(params[:friend_id])
      if @friendship.save
        # UserMailer.user_notification(@user,@friend_id).deliver!  if @user.email_notification?
        flash[:notice] = "You are now supporting " + @user.first_name
      else
        flash[:error] = "Error occur when supporting " + @user.first_name
      end
      redirect_to :back and return
    end
  end

  def unsupport
    if current_user.friendships.find_by_friend_id(params[:friend_id]).present?
      @friendship = current_user.friendships.find_by_friend_id(params[:friend_id])
      @friendship.destroy
      flash.now[:notice] = "Successfully destroyed friends."
      redirect_to :back and return
    end
  end

  def spread_post
    if params[:post_id].present?
      post  = Post.find(params[:post_id])
      @post = current_user.posts.build(:name => post.name)
      if @post.save
        flash.now[:notice] = "Post Successfully Shared."
      else
        flash.now[:error] = "Someting went to wrong."
      end
      redirect_to :back and return
    end
  end

  def add_user
    if params[:friend_id].present?
      @friendship = current_user.friendships.build(:friend_id => params[:friend_id].to_i, :accepted => 'pending')
      if @friendship.save
        flash.now[:notice] = "Your request has been sent."
      else
        flash.now[:error] = "Error occurred when adding friend."
      end
      redirect_to :back and return
    end
  end

  def removed_user
    if params[:friend_id].present?
      @friendship = current_user.friendships.build(:friend_id => params[:friend_id].to_i, :accepted => 'pending', :removed_user => true)
      if @friendship.save
        flash[:notice] = "Successfully Removed friend."
      else
        flash[:error] = "Some went Wrong."
      end
      redirect_to :back and return
    end
  end

  def remove_friend
    if params[:user_id] && params[:friend_id]
      friendship = Friendship.find_friend_by_user_and_friend_id(params[:user_id], params[:friend_id]).first 
      unless friendship.nil?
        friendship.update_attributes(:removed_friend => true)
      end
      redirect_to :back and return
    end
  end

  def accept_friend_request
    if params[:friend_id].present?
      @friendship = Friendship.find(params[:friend_id])
      @friendship.update_attributes(:accepted => 'approved')
      flash[:notice] = "Accept friend request."
      redirect_to :back and return
    end
  end

  def deny_friend_request
    if params[:friend_id].present?
      @friendship = Friendship.find(params[:friend_id])
      @friendship.update_attributes(:accepted => 'unapproved')
      flash[:notice] = "Deny friend request."
      redirect_to :back and return
    end
  end

  def user_profile
    if params[:id].present?
      @user            = User.find(params[:id])
      @user_supporters = User.where(id: Friendship.where(friend_id: @user.id ).pluck(:user_id)    )
      @post            = Post.first
      @posts           = @user.posts.uniq if @user.posts.present?
      @comments        = @post.comments if @post.present?
    end
  end

  def glis_support
    @friend_requests = Friendship.where('user_id !=? AND accepted=? AND friend_id =?', current_user.id, 'pending', current_user.id) if user_signed_in?
  end

  private

  def authorize
    unless user_signed_in?
      redirect_to root_path
    end
  end

end
