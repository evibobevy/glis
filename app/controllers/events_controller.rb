class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :join_volunteer, :disjoin_volunteers, :join_gigs]
  before_filter :authorize, only: [:join_volunteer, :disjoin_volunteers, :list_users, :find_mutual_friends, :friendsearch_request]
  before_filter :glis_support ,except: [:support, :unsupport]
  before_filter :find_latest_month_gigs, :only => :event_list
  before_filter :find_mutual_friends ,only: :friendsearch_request
  before_filter :login_user_friend ,only: :index
  before_filter :checkuser_for_calendar ,only: :event_list
  respond_to :html, :js, :json
  # layout "fancybox", only: :event_list

  def authorize
    unless user_signed_in?
      redirect_to root_path
    end
  end

  def index
    @events         = Event.includes(:posts).last(3)
    @post           = Post.event_posts.first if Post.event_posts.first.present?
    @posts          = current_user.friends.collect {|i| i.posts}.flatten.uniq if user_signed_in?
    @comments       = @post.comments if @post.present?
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
    @event.user_role = Event.user_roles[params[:user_role].downcase.to_sym]
    @event.type_of_gig = Event.type_of_gigs[params[:type_of_gig].downcase.to_sym]
    @event.user_id = current_user.id
    if @event.save && params[:images].present?
      params[:images].each do |image|
        @picture = @event.pictures.create(:image => image)
      end
      flash[:success] = "GIG successfully created.."
    else
      flash[:notice] = "Something went Wrong.."
    end
    redirect_to event_list_path
  end

  def update
    @event.update(event_params)
    respond_with(@event)
  end

  def destroy
    @event.destroy
    respond_with(@event)
  end

  def join_gigs
    render layout: 'fancybox'
  end
  #
  # def disjoin_volunteer
  #   event = Event.find(params[:id])
  #   current_user.events << event
  #   current_user.events.delete(event)
  #   flash[:notice] = "Successfully DisJoin"
  #   redirect_to root_path
  # end

  def event_list
    if params[:date].present? && params[:is_mobile] == "true"
      @today_gigs_mobile = Event.where('event_date = ?',Date.strptime(params[:date], "%m/%d/%Y"))
    end
    if params[:start_date].present?
      @next_month_event = Event.where('extract(year from event_date) = ? AND extract(month from event_date) = ?', Date.parse(params[:start_date]).year, Date.parse(params[:start_date]).month)
    end
    @today_gigs = Event.today_event
    @event = Event.new
    layout = user_signed_in? ? 'application' : 'fancybox'
    if params[:is_mobile] == "true"
      respond_to do |format|
        format.js  { render layout: false }
        format.html
      end
    else
      render layout: layout
    end
  end

  def join_event
    if params[:event_id].present?
      @event = Event.find(params[:event_id])
      current_user.events << @event
      flash[:notice] = "Successfully Join Event"
      redirect_to :back and return
    end
  end

  def friendsearch_request
    #@type_of_gigs = Event.type_of_gigs
  end

  def search_users
    if !params[:type_of_gig].present?
      @users = User.where("(lower(city) LIKE ? AND lower(first_name) LIKE ?)" ,"%#{params[:search_location].downcase}%", "%#{params[:search_user].downcase}%")
    else
      @users = User.joins(:events).where("(lower(first_name) LIKE ? AND lower(city) LIKE ?) AND events.type_of_gig = '#{(Event.type_of_gigs[params[:type_of_gig].downcase])}'","%#{params[:search_user].downcase}%", "%#{params[:search_location].downcase}%")
    end
  end

  def search_gigs
    if params[:search_gigs].present?
      @search_user = User.search(params[:search_gigs])
      @search_foundation = Foundation.search(params[:search_gigs])
      # @search_result = User.joins(:foundations).where("fo undations.name = '%#{params[:search_gigs]}%' OR users.first_name='%#{params[:search_gigs]}%'")
    end
    render layout: 'fancybox'
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

  def glis_support
    @friend_requests = Friendship.where('friend_id =? AND accepted=? AND user_id !=?', current_user.id,'pending',current_user.id) if user_signed_in?
  end

  def find_latest_month_gigs
    @latest_month_gigs = Event.latest_months_event
    @events = Event.all

  end

  def find_mutual_friends
    @mutual_friends = current_user.friends.collect {|i| i.friends}.flatten.uniq.reject{|user| user == current_user} - current_user.friends
  end

  def login_user_friend
    @user_supporters = current_user.friendships.find_unremove_friend.reject{|user| user.friend_id == current_user.id}  if user_signed_in?
  end

  def checkuser_for_calendar
    if !user_signed_in? && !request.xhr?
      redirect_to new_user_session_path
    end
  end

end
