class RegistrationsController < Devise::RegistrationsController
  before_action :set_user, only: [:edit, :update, :update_password]
  layout "fancybox", :only => [:new, :create]

  def new
    super
  end

  def create
    build_resource(sign_up_params)
    if resource.valid? && resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        return render :json => { :success => true }
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        return render :json => { :success => true }
      end
    else
      puts resource.errors.full_messages.inspect
      clean_up_passwords resource
      return render :json => { :success => false, :error => resource.errors.full_messages }
    end
  end

  def edit
    @user_pictures  = current_user.user_pictures.last(4)  if user_signed_in?
    @supporters = current_user.friendships.find_unremove_friend.reject{|user| user.friend_id == current_user.id}  if user_signed_in?
    @picture = UserPicture.new
  end

  def update
    super
  end

  def profile_settings
    @user_picture  = UserPicture.new
    @user_settings = User::USER_PRIVACY_SETTINGS
  end

  def edit_user
  end

  def edit_location
  end

  def edit_description
  end

  def edit_email
  end

  def edit_phone
  end

  def update_user
    @user            = User.find_by_id(current_user.id)
    @user.first_name = params[:first_name] if params[:first_name].present?
    @user.last_name  = params[:last_name] if params[:last_name].present?
    @user.save
  end

  def update_location
    @user       = User.find_by_id(current_user.id)
    @user.city  = params[:city] if params[:city].present?
    @user.state = params[:state] if params[:state].present?
    @user.save
  end

  def update_description
    @user             = User.find_by_id(current_user.id)
    @user.description = params[:description] if params[:description].present?
    @user.save
  end

  def update_email
    @user       = User.find_by_id(current_user.id)
    @user.email = params[:email] if params[:email].present?
    @user.save
  end

  def update_phone
    @user              = User.find_by_id(current_user.id)
    @user.phone_number = params[:phone_number] if params[:phone_number].present?
    @user.save
  end

  def update_password
    @user.password = params[:password] if params[:password].present?
    @user.password_confirmation = params[:password_confirmation] if params[:password].present?
    @user.save
    flash[:alert] = "Password successfully update. "
    redirect_to new_user_session_path
  end

  def update_settings
    p "============================"
    p params
    p "============================"
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :confirm_email, :password, :password_confirmation, :first_name, :last_name)
  end


  def account_update_params
    params.require(:user).permit(:email, :first_name, :last_name, :city, :state, :image, :description, :password, :password_confirmation, :everyone_view_your_profile, :everyone_view_your_calendar, :everyone_invite_you_to_events, :everyone_view_your_post, :everyone_message_you, :volunteers_need_approval_join_your_gigs, :supporters_need_approval_to_comment, :email_notification, :sms_notification, :mobile_ping_notifications, :phone_number )
  end


  def set_user
    @user = User.find_by_id(current_user.id)
    @user_supporters = current_user.friendships.find_unremove_friend if user_signed_in?
  end

  protected

  def after_update_path_for(resource)
    edit_user_registration_path
  end
end
