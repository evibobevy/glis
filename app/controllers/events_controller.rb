class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :join_volunteer, :disjoin_volunteers]
  before_filter :authorize, only: [:join_volunteer, :disjoin_volunteers, :friendsearch_request]
  respond_to :html,:js

  def authorize
    unless user_signed_in?
      redirect_to new_user_registration_path
    end
  end

  def index
    @users = User.all
    @friend_requests = Friendship.where('friend_id =? AND accepted=? AND user_id !=?', current_user.id,'pending',current_user.id) if user_signed_in?
    @events = Event.last(3)
    @post = Post.last
    @comments = @post.comments unless @post.nil?
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
    @event.save
    respond_with(@event)
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
    @event_list = Event.all
    @latest_month_event = Event.this_months_event
    render layout: 'fancybox'
  end

  def friendsearch_request
    @mutual_friends  = current_user.friends
    if  params[:search_user].present? || params[:search_location].present?
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
      params.require(:event).permit(:title, :event_date,:image, :start_time, :end_date)
    end
end
