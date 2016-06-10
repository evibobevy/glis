class FriendshipsController < ApplicationController
  before_filter :authorize, only: [:support, :unsupport]
  before_filter :find_mutual_friends ,except: [:support, :unsupport]

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
          flash[:error] = "Error occurred when adding friend."
          redirect_to root_url
        end
     end
  end

  def unsupport
    if  current_user.friendships.find_by_friend_id(params[:friend_id]).present?
      @friendship = current_user.friendships.find_by_friend_id(params[:friend_id])
      @friendship.destroy
      flash[:notice] = "Successfully destroyed friendship."
      redirect_to root_url
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

  private

  def find_mutual_friends
    @mutual_friends = current_user.friends if user_signed_in?
  end

end
