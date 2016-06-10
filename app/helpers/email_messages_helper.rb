module EmailMessagesHelper
  def find_user_by_friend_id(friend_request)
    User.find(friend_request)
  end

  def find_fullname_by_user_id(friend)
    User.find_by_id(friend.user_id)
  end
end
