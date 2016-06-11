class UserPicturesController < ApplicationController

  def create
    # abort params.inspect
    user = current_user
    @user_picture = UserPicture.new(user_picture_params)
    if @user_picture.save
      if params[:user_picture][:image].present?
        # params[:image].each do |image|
        #user.user_pictures.create(:image => params[:user_picture][:image])
        #@user_picture.user_id = user.id
        #end
        flash[:notice] = "Picture Added."
        #redirect_to :back and return
        redirect_to :controller => 'registrations', :action => 'profile_settings'
      else
        render action: "new"
      end
    end
  end

  private

  def user_picture_params
    params.require(:user_picture).permit(:image, :user_id)
  end
end
