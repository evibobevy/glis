module UserPicturesHelper
  def get_user_photos(current_user)
    user_pictures = UserPicture.where(user_id: current_user.id).last(4)
  end
end
