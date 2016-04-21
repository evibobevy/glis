class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_and_belongs_to_many :events, join_table: :events_users
  has_many :posts, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, :through => :friendships
  has_attached_file :image, styles: { medium: "150x200#", thumb: "100x100#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  # validates_attachment :image, presence: true, unless: -> { from_omniauth? }
  validates :first_name, :last_name, :confirm_email, :presence => true, unless: -> { from_omniauth? }
  validates :email, confirmation: true
  def full_name
    self.first_name + " " + self.last_name
  end

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