class UserPicturesController < ApplicationController
  before_filter :authorize, only: :update

  def update
    if params[:user_picture][:user_picture_id].present? && user_signed_in? && params[:user_picture][:image].present?
      @user_picture = current_user.user_pictures.find_by_id(params[:user_picture][:user_picture_id])
      if @user_picture.update_attributes(image:params[:user_picture][:image])
        flash[:notice] = "User Pictures Update."
      else
        flash[:notice] = "Someting went wrong for User Picture."
      end
      redirect_to :back and return
    else
      @user_picture = current_user.user_pictures.build(user_picture_params)
      if @user_picture.save
        redirect_to :back and return
        flash[:notice] = "Picture Created."
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
      redirect_to root_path
    end
  end
end
