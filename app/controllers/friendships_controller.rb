class FriendshipsController < ApplicationController
  before_filter :authorize, only: [:support, :unsupport]

  def authorize
    unless user_signed_in?
      redirect_to new_user_registration_path
    end
  end

  def support
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id].to_i, :accepted => 'pending')
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to root_url
    else
      flash[:error] = "Error occurred when adding friend."
      redirect_to root_url
    end
  end

  def unsupport
    @friendship = current_user.friendships.find_by_friend_id(params[:friend_id])
    @friendship.destroy
    flash[:notice] = "Successfully destroyed friendship."
    redirect_to root_url
  end

  def accept_friend_request
    @friendship = Friendship.find(params[:friend_id])
    @friendship.update_attributes(:accepted => 'approved')
    redirect_to :back
  end

  def deny_friend_request
    @friendship = Friendship.find(params[:friend_id])
    @friendship.update_attributes(:accepted => 'unapproved')
    redirect_to :back
  end
end
