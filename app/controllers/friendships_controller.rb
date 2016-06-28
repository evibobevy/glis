class FriendshipsController < ApplicationController
  before_filter :authorize, only: :support

  def authorize
    unless user_signed_in?
      redirect_to new_user_registration_path
    end
  end

  def support
    if params[:friend_id].present?
      @friendship = current_user.friendships.build(:friend_id => params[:friend_id].to_i, :accepted => 'pending')
      if @friendship.save
        flash[:notice] = "Added friend."
        redirect_to root_url
      else
        flash[:error] = "Error occur when adding friend."
        redirect_to root_url
      end
    end
  end

  def add_user
    if params[:friend_id].present?
      @friendship = current_user.friendships.build(:friend_id => params[:friend_id].to_i, :accepted => 'pending')
      if @friendship.save
        flash[:notice] = "Added friend."
        redirect_to root_url
      else
        flash[:error] = "Error occurred when adding friend."
        redirect_to root_url
      end
    end
  end

  def removed_user
    if params[:friend_id].present?
      @friendship = current_user.friendships.build(:friend_id => params[:friend_id].to_i, :accepted => 'pending', :removed_user=> true)
      if @friendship.save
        flash[:notice] = "Removed friend."
        redirect_to :back
      else
        flash[:error] = "Error occurred when removing friend."
        redirect_to :back
      end
    end
  end

  def remove_friend
    if  params[:user_id] && params[:friend_id]
      friendship = Friendship.find_friend_by_user_and_friend_id(params[:user_id],params[:friend_id]).first
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
      redirect_to :back
    end
  end

  def deny_friend_request
    if params[:friend_id].present?
      @friendship = Friendship.find(params[:friend_id])
      @friendship.update_attributes(:accepted => 'unapproved')
      redirect_to :back
    end
  end

  def glisSupportPage
    @friend_requests = Friendship.where('friend_id =? AND accepted=? AND user_id !=?', current_user.id,'pending',current_user.id) if user_signed_in?
  end

end
