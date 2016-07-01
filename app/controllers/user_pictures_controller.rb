class UserPicturesController < ApplicationController
  before_filter :authorize, only: :update

  def update
    if params[:user_picture][:user_picture_id].present? && user_signed_in?
      @user_picture = current_user.user_pictures.find_by_id(params[:user_picture][:user_picture_id])
      #   @user_picture.image = params[:user_picture][:image])
      #   @user_picture = current_user.user_pictures.build(user_picture_params)
      #@user_picture.present? ? (@user_picture.image = params[:user_picture][:image]) : @user_picture = current_user.user_pictures.create(user_picture_params)
      if @user_picture.update_attributes(image:params[:user_picture][:image])
        flash[:notice] = "Picture Update."
        redirect_to :back and return
      else
        redirect_to edit_user_registration_path
      end
    else
      @user_picture = current_user.user_pictures.build(user_picture_params)
      if @user_picture.save!
        flash[:notice] = "Picture Created."
        redirect_to :back and return
      else
        redirect_to edit_user_registration_path
      end
    end
  end

  private

  def user_picture_params
    params.require(:user_picture).permit(:image, :user_id)
  end

  def authorize
    unless user_signed_in?
      redirect_to new_user_registration_path
    end
  end
end
