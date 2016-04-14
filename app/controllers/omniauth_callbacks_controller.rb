class OmniauthCallbacksController < ApplicationController
  def facebook
    auth = env["omniauth.auth"]
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"],current_user)
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_uid"] = request.env["omniauth.auth"]
      redirect_to root_path
    end
  end
end
