class FoundationsController < ApplicationController
  before_action :set_foundation, only: [:show, :edit, :update, :destroy]
  before_filter :find_latest_month_foundation, :only => :foundation_calendar
  respond_to :html, :js

  def new
    @foundation = Foundation.new
    respond_with(@foundation)
  end

  def create
    @foundation = Foundation.new(foundation_params)
    @foundation.user_role = Foundation.user_roles[params[:user_role].downcase.to_sym]
    @foundation.type_of_foundation = Foundation.type_of_foundations[params[:type_of_foundation].downcase.to_sym]
    @foundation.user_id = current_user.id
    if @foundation.save
      if params[:images].present?
        params[:images].each do |image|
          @picture = @foundation.foundation_pictures.create(:image => image)
        end
        flash[:notice] = "Event Added."
      else
        flash[:notice] = "Some thing went Wrong......."
      end
      redirect_to :back and return
    end
  end

  def edit
    @foundation_pictures  = @foundation.foundation_pictures.last(4)
    @picture = FoundationPicture.new
  end

  def update
    @foundation.update!(foundation_params)
    redirect_to :back and return
  end

  def foundation_calendar
    @foundation = Foundation.new
    if params[:start_date].present?
      @next_month_foundation = Foundation.where('extract(year from start_date) = ? AND extract(month from end_date) = ?', Date.parse(params[:start_date]).year, Date.parse(params[:start_date]).month)
    end
    @today_foundation = Foundation.today_foundation
  end

  def show
    @posts = @foundation.posts
    @post = Post.first
  end

  private

  def set_foundation
    @foundation = Foundation.find(params[:id])
  end

  def find_latest_month_foundation
    @latest_month_foundation = Foundation.latest_months_foundation
  end

  def foundation_params
# params.require(:foundation).permit(:name, :city, :state, :description, :everyone_view_profile, :everyone_view_calendar, :everyone_invite_you_to_events, :everyone_view_posts, :everyone_message_you, :volunteers_need_approval_to_join_your_gigs, :supporters_need_approval_to_comment_on_your_posts, :phone_number, :email_notifications, :text_notifications, :mobile_ping_notifications, :image)
  params.require(:foundation).permit(:name, :city, :description, :start_date, :end_date, :start_time, :end_time, :anyone_volunteer, :open_to_the_public, :recurring, :basic_info, :description, :everyone_view_profile, :everyone_view_calendar, :everyone_invite_you_to_events, :everyone_view_posts, :everyone_message_you, :volunteers_need_approval_to_join_your_gigs, :supporters_need_approval_to_comment_on_your_posts, :phone_number, :email_notifications, :text_notifications, :mobile_ping_notifications, :image, :user_role, :type_of_foundation)
  end
end
