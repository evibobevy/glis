class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :join_volunteer, :disjoin_volunteers]
  before_filter :authorize, only: [:join_volunteer, :disjoin_volunteers, :list_users, :find_mutual_friends]
  before_filter :glisSupportPage ,except: [:support, :unsupport]
  before_filter :find_latest_month_gigs, :only => :event_list
  before_filter :find_mutual_friends ,only: :friendsearch_request
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
    Event.type_of_gigs[params[:type_of_gig].downcase.to_sym].inspect
    @event.user_role = Event.user_roles[params[:event][:user_role].to_sym]
    @event.type_of_gig = Event.type_of_gigs[params[:type_of_gig].downcase.to_sym]
    if @event.save
      if params[:images].present?
        params[:images].each do |image|
          @picture = @event.pictures.create(:image => image)
        end
        current_user.events << @event
        flash[:notice] = "Event Added."
        redirect_to root_path
      else
        redirect_to :back and return
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
    @event = Event.new
    if params[:start_date].present?
      @next_month_event = Event.where('extract(year from event_date) = ? AND extract(month from event_date) = ?', Date.parse(params[:start_date]).year, Date.parse(params[:start_date]).month)
    end
    layout = user_signed_in? ? 'application' : 'fancybox'
    render layout: layout
  end


  def friendsearch_request
    #@type_of_gigs = Event.type_of_gigs
  end

  def search_users
    if params[:search_user].present? || params[:search_location].present? || params[:type_of_gig].present?
      @users = User.joins(:events).where("lower(first_name) LIKE ? OR lower(city) LIKE ? OR events.type_of_gig = ?","%#{params[:search_user].downcase}%", "%#{params[:search_location].downcase}%", Event.type_of_gigs[params[:type_of_gig].downcase]).uniq
      #@users = User.joins(:events).where("lower(city) LIKE ? OR lower(first_name) LIKE ? OR events.type_of_gig = ? " ,"%#{params[:search_location].downcase}%", "%#{params[:search_user].downcase}%", Event.type_of_gigs[params[:type_of_gig].downcase])
      p "======="
      p @users.count.inspect
      p "======="
    end
  end

  def sitemap
    @event = Event.last
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :location, :start_time, :event_date, :end_date, :event_start_time, :event_end_time, :anyone_volunteer, :open_to_the_public, :recurring, :foundation_name, :basic_info, :full_description, :type_of_gig, :user_role)
  end

  def glisSupportPage
    @friend_requests = Friendship.where('friend_id =? AND accepted=? AND user_id !=?', current_user.id,'pending',current_user.id) if user_signed_in?
  end

  def find_latest_month_gigs
    @latest_month_gigs = Event.latest_months_event
  end

  def find_mutual_friends
    @mutual_friends = current_user.friends.collect {|i| i.friends}.flatten.uniq.reject{|user| user == current_user} - current_user.friends
  end

end
