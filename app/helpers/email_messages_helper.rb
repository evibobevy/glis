module EmailMessagesHelper
  def find_user_by_friend_id(friend_request)
    User.find(friend_request)
  end

  def find_fullname_by_user_id(friend)
    User.find_by_id(friend.user_id)
  end

  def time_diff_for_email_message(email_message)
    seconds = (TimeDifference.between(Time.now,email_message.created_at ).in_seconds.to_i)
    mm, ss = seconds.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)
  end

end
