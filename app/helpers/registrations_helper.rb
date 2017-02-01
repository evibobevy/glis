module RegistrationsHelper
  def find_user_by_id(user_id)
    User.find_by_id(user_id)
  end
end
