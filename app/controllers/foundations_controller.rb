class FoundationsController < ApplicationController
  before_action :set_foundation, only: [:show, :update, :destroy]
  before_filter :find_latest_month_foundation, :only => :foundation_calendar
  before_filter :authorize, only: [:foundation_calendar, :edit, :show]
  respond_to :html, :js, :json

  def new
    @foundation = Foundation.new
    respond_with(@foundation)
  end

  def index
    redirect_to root_path
  end

  def create
    @foundation                    = Foundation.new(foundation_params)
    @foundation.user_role          = Foundation.user_roles[params[:user_role].downcase.to_sym]
    @foundation.type_of_foundation = Foundation.type_of_foundations[params[:type_of_foundation].downcase.to_sym]
    @foundation.user_id            = current_user.id
    if @foundation.save && params[:images].present?
      params[:images].each do |image|
        @picture = @foundation.foundation_pictures.create(:image => image)
      end
      flash[:success] = "Foundation successfully created.."
      redirect_to edit_foundation_path(@foundation)
    else
      flash[:notice] = "Something went Wrong.."
      redirect_to foundation_calendar_path
    end

  end

  def edit
    if params[:id].present?
      @foundation      = Foundation.find(params[:id])
      @foundation_pictures = @foundation.foundation_pictures.last(4)
      @picture             = FoundationPicture.new
    end
  end

  def update
    @foundation.update(foundation_params)
    if params[:email].present?
      if @foundation.user.update_attributes(:email => params[:email])
        flash[:success] = "Foundation successfully updated.."
      else
        flash[:notice] = "Something went Wrong.."
      end
    end
    redirect_to :back and return
  end

  def support_foundation
    if params[:id].present? && params[:support].present?
     @foundation  = Foundation.find(params[:id])
      current_user.foundations << @foundation
      flash[:notice] = "Successfully Join Foundation"
     redirect_to :back and return
    end
  end

  def foundation_calendar
    @new_foundation = Foundation.new
    @upcoming_foundations = Foundation.next_months_foundations
    if params[:start_date].present?
      @next_month_foundation = Foundation.where('extract(year from start_date) = ? AND extract(month from end_date) = ?', Date.parse(params[:start_date]).year, Date.parse(params[:start_date]).month)
    end
    if params[:popout_calendar].present?
      render layout: 'fancybox'
    else
      render layout: 'application'
    end
    @today_foundation = Foundation.today_foundation
  end

  def show
    @posts         = @foundation.posts if @foundation.present?
    @post          = Post.find_by_postable_type("Foundation")
    @upcoming_gigs = Event.next_months_gigs
    @foundation_supporters = @foundation.users  if @foundation.present?
  end

  def user_foundations
    # render layout: 'fancybox'
  end

  private

  def set_foundation
    @foundation      = Foundation.find(params[:id])
    @foundation_user = @foundation.user if @foundation.present?
  end

  def find_latest_month_foundation
    @latest_month_foundation = Foundation.latest_months_foundation
  end

  def foundation_params
# params.require(:foundation).permit(:name, :city, :state, :description, :everyone_view_profile, :everyone_view_calendar, :everyone_invite_you_to_events, :everyone_view_posts, :everyone_message_you, :volunteers_need_approval_to_join_your_gigs, :supporters_need_approval_to_comment_on_your_posts, :phone_number, :email_notifications, :text_notifications, :mobile_ping_notifications, :image)
    params.require(:foundation).permit(:name, :city, :description, :start_date, :end_date, :start_time, :end_time, :anyone_volunteer, :open_to_the_public, :recurring, :basic_info, :description, :everyone_view_profile, :everyone_view_calendar, :everyone_invite_you_to_events, :everyone_view_posts, :everyone_message_you, :volunteers_need_approval_to_join_your_gigs, :supporters_need_approval_to_comment_on_your_posts, :phone_number, :email_notifications, :text_notifications, :mobile_ping_notifications, :image, :user_role, :type_of_foundation, :state)
  end

  def authorize
    unless user_signed_in?
      redirect_to root_path
    end
  end
end
