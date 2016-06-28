class Friendship < ActiveRecord::Base
  belongs_to :friend, :class_name => "User"
  scope :find_friend_by_user_and_friend_id, lambda  { |user, friend| where("user_id = ? AND friend_id = ?", user, friend) }
  scope :find_not_remove_friend, -> { where(removed_friend: false) }

  def find_fullname_by_friend_id
    self.friend.full_name
  end

end
