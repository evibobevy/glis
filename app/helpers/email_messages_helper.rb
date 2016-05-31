module EmailMessagesHelper
  def find_user_by_friend_id(friend_request)
    User.find(friend_request)
  end
end
