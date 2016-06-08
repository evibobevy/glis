class RegistrationsController  < Devise::RegistrationsController
  layout "fancybox", :only => [:new,:create]

  def new
    super
  end

  def create
    build_resource(sign_up_params)
    if resource.valid? && resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        return render :json => {:success => true}
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        return render :json => {:success => true}
      end
    else
      puts resource.errors.full_messages.inspect
      clean_up_passwords resource
      return render :json => {:success => false, :error=> resource.errors.full_messages}
    end
  end

  def profile_settings
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
    @user = User.find_by_id(current_user.id)
    @user.first_name = params[:first_name] if params[:first_name].present?
    @user.last_name = params[:last_name] if params[:last_name].present?
    @user.save
  end

  def update_location
    @user = User.find_by_id(current_user.id)
    @user.city = params[:city] if params[:city].present?
    @user.state = params[:state] if params[:state].present?
    @user.save
  end

  def update_description
    @user = User.find_by_id(current_user.id)
    @user.description = params[:description] if params[:description].present?
    @user.save
  end

  def update_email
    @user = User.find_by_id(current_user.id)
    @user.email = params[:email] if params[:email].present?
    @user.save
  end

  def update_phone
    @user = User.find_by_id(current_user.id)
    @user.phone_number = params[:phone_number] if params[:phone_number].present?
    @user.save
  end

  def update_settings
    p "============================"
    p params
    p "============================"
  end


  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :image, :first_name, :last_name, :confirm_email)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :image, :first_name, :last_name, :confirm_email)
  end
end
