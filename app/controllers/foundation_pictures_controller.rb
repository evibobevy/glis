class FoundationPicturesController < ApplicationController
  before_filter :authorize, only: :update

  def update
    if params[:foundation_picture][:user_foundation_picture_id].present? && user_signed_in?
      @foundation = Foundation.find(params[:foundation_id])
      @picture = @foundation.foundation_pictures.find_by_id(params[:foundation_picture][:user_foundation_picture_id])
      if @picture.update_attributes(image:params[:foundation_picture][:image])
        flash[:notice] = "Foundation Picture Update."
      else
        flash[:notice] = "Someting went wrong for Foundation Picture."
      end
      redirect_to edit_foundation_path(@foundation)
    else
      @foundation = Foundation.find(params[:foundation_id])
      @foundation_pictures = @foundation.foundation_pictures.build(foundation_picture_params)
      if @foundation_pictures.save
        flash[:notice] = "Foundation picture Added."
      else
        flash[:notice] = "Error Foundation picture."
      end
      redirect_to edit_foundation_path(@foundation)
    end
  end

  def authorize
    unless user_signed_in?
      redirect_to new_user_registration_path
    end
  end

  private

  def foundation_picture_params
    params.require(:foundation_picture).permit(:image, :foundation_id)
  end
end
