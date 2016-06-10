class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :join_volunteer, :disjoin_volunteers]
  before_filter :authorize, only: [:join_volunteer, :disjoin_volunteers, :friendsearch_request, :list_users]
  before_filter :glisSupportPage ,except: [:support, :unsupport]
  respond_to :html, :js

  def authorize
    unless user_signed_in?
      redirect_to new_user_registration_path
    end
  end

  def index
    @events         = Event.last(3)
    @post           = Post.last
    @comments       = @post.comments unless @post.nil?
    @last_six_users = User.last(6)
    respond_with(@events)
  end

  def show
    respond_with(@event)
  end

  def new
    @event = Event.new
    respond_with(@event)
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      if params[:images].present?
        params[:images].each do |image|
          @picture = @event.pictures.create(:image => image)
        end
        flash[:notice] = "Event Added."
        redirect_to :back and return
      else
        render action: "new"
      end
    end
  end

  def update
    @event.update(event_params)
    respond_with(@event)
  end

  def destroy
    @event.destroy
    respond_with(@event)
  end

  def join_volunteer
    event = Event.find(params[:id])
    current_user.events << event
    flash[:notice] = "Successfully Join"
    redirect_to event_path(event)
  end

  def disjoin_volunteer
    event = Event.find(params[:id])
    current_user.events << event
    current_user.events.delete(event)
    flash[:notice] = "Successfully DisJoin"
    redirect_to root_path
  end

  def event_list
    if params[:start_date].present?
      @next_month_event = Event.where('extract(year from start_time) = ? AND extract(month from start_time) = ?', Date.parse(params[:start_date]).year, Date.parse(params[:start_date]).month)  if !params[:previous_link].present?
      @past_gigs = Event.where('extract(year from start_time) = ? AND extract(month from start_time) = ?', Date.parse(params[:start_date]).year, Date.parse(params[:start_date]).month) if params[:previous_link].present? && !params[:next_link].present?
    else
      @next_month_event = Event.where(:start_time=> Time.zone.now..Time.zone.now.end_of_month)
      @past_gigs = Event.where(:start_time => Time.zone.now.beginning_of_month...Time.zone.now.beginning_of_day)
    end
    @today_gigs = Event.where("start_time = ?", Time.zone.now.beginning_of_day)
    @event_list = Event.all
    @event = Event.new
    render layout: 'fancybox'
  end


  def friendsearch_request
    @mutual_friends = current_user.friends
    if params[:search_user].present? || params[:search_location].present?
      @users = @mutual_friends.where('first_name LIKE ? AND location LIKE ?', "%#{params[:search_user]}%", "%#{params[:search_location]}%")
    else
      @users = @mutual_friends.all
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :location, :start_time, :event_date, :event_start_time, :event_end_time, :basic_info, :full_description)
  end

  def glisSupportPage
    @friend_requests = Friendship.where('friend_id =? AND accepted=? AND user_id !=?', current_user.id,'pending',current_user.id) if user_signed_in?
  end

end
