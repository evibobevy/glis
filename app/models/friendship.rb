class Friendship < ActiveRecord::Base
  belongs_to :friend, :class_name => "User"

  def find_fullname_by_friend_id
    self.friend.full_name
  end
end
