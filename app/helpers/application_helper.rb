module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def get_user_notifications(current_user)
    {"Email Notifications to: " => current_user.email, "Text Notifications to: " => current_user.phone_number, "Mobile Ping Alerts" => ''}
  end
end
