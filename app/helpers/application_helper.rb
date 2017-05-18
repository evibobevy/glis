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

 def bootstrap_class_for(flash_type)
  case flash_type
  when "success"
    "alert-success"   # Green
  when "error"
    "alert-danger"    # Red
  when "alert"
    "alert-warning"   # Yellow
  when "notice"
    "alert-info"      # Blue
  else
    flash_type.to_s
  end
end


end
