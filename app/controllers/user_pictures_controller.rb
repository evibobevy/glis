class UserPicturesController < ApplicationController
  before_filter :authorize, only: :update

  def update
    if params[:user_picture][:user_picture_id].present? && user_signed_in? && params[:user_picture][:image].present?
      @user_picture = current_user.user_pictures.find_by_id(params[:user_picture][:user_picture_id])
      if @user_picture.update_attributes(image:params[:user_picture][:image])
        flash[:notice] = "Picture Update."
      else
        flash[:notice] = "Someting went wrong for User Picture."
      end
      redirect_to :back and return
    else
      @user_picture = current_user.user_pictures.build(user_picture_params)
      if @user_picture.save
        flash[:notice] = "Picture Created."
        redirect_to :back and return
      else
        redirect_to :back and return
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
