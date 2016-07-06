class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_and_belongs_to_many :events, join_table: :events_users
  has_many :posts, dependent: :destroy
  has_many :email_messages, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, :through => :friendships
  has_many :user_pictures, :dependent => :destroy
  has_attached_file :image, styles: { medium: "150x200#", thumb: "100x100#", default_url: "noImg.jpg" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  # validates_attachment :image, presence: true, unless: -> { from_omniauth? }
  validates :first_name, :last_name, :confirm_email, :presence => true, unless: -> { from_omniauth? }
  validates :email, confirmation: true
  validates_length_of :phone_number, maximum: 10
  # USER_ROLE = {
  #     :Group_Leader => 1,
  #     :Volunteer => 2
  # }
  #
  # enum role_of_user: [ :group_leader, :volunteer ]

  USER_PRIVACY_SETTINGS = {"Who can see my profile" => 'user_profile_settings', "Who can comment on my posts" => 'user_post_comments_settings', "Who can message me" => 'user_message_settings', "Who can invite me to events" => 'user_events_invite_settings'}

  def full_name
    self.first_name.capitalize + " " + self.last_name.capitalize  if self.first_name.present? || self.last_name.present?
  end

  def full_address
    self.city.capitalize + ", " + self.state.upcase  if self.city.present? || self.state.present?
  end

  def last_name_initial
    self.first_name + " " + self.last_name[0] + '.'
  end

  def self.search(search)
    if search
      where('first_name LIKE ?', "%#{search}%")
    end
  end

  def update_with_password(params={})
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    update_attributes(params)
  end

  # def update_with_password(params, *options)
  #   current_password = params.delete(:current_password)
  #
  #   if params[:password].blank?
  #     params.delete(:password)
  #     params.delete(:password_confirmation) if params[:password_confirmation].blank?
  #   end
  #
  #   result = if params[:password].blank? || valid_password?(current_password)
  #              update_attributes(params, *options)
  #            else
  #              self.assign_attributes(params, *options)
  #              self.valid?
  #              self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
  #              false
  #            end
  #
  #   clean_up_passwords
  #   result
  # end


  private

  def from_omniauth?
    provider && uid
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.uid + "@facebook.com").first
      if registered_user
        return registered_user
      else
        user = User.create!(provider:      auth.provider,
                            profile_image: auth["info"]["image"],
                            first_name:    auth["info"][:name].scan(/[\w'-]+/).first,
                            last_name:     auth["info"][:name].scan(/[\w'-]+/).last,
                            uid:           auth.uid,
                            email:         auth["info"]['email'],
                            password:      Devise.friendly_token[0, 20])
      end
    end
  end
end