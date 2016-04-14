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

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :image, :first_name, :last_name, :confirm_email)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :image, :first_name, :last_name, :confirm_email)
  end
end
