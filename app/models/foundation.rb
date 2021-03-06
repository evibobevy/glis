class Foundation < ActiveRecord::Base
  has_many :foundation_pictures, :dependent => :destroy
  has_many :posts , :as => :postable
  belongs_to :user
  has_and_belongs_to_many :users, join_table: :foundations_users
  # has_attached_file :image, :path => ":rails_root/public/images/:id/:filename", :url  => "/images/:id/:filename", default_url: "/assets/stayIcon.png"
  has_attached_file :image,
                    :storage        => :s3,
                    :s3_host_name   => 's3-us-west-2.amazonaws.com',
                    :path           => "#{Rails.env}/foundations/:id/:style/:filename",
                    :s3_region      => 'us-west-2',
                    :s3_protocol    => :https,
                    :s3_credentials => YAML.load_file("#{Rails.root}/config/aws.yml"),
                    :default_url    => '/assets/stayIcon.png'
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  scope :today_foundation, lambda { where("start_date = ? ", Time.zone.now.beginning_of_day) }
  scope :latest_months_foundation, lambda { where("start_date >= ? AND end_date <= ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month) }
  scope :next_months_foundations, lambda { where("start_date >= ? AND end_date <= ?", Time.zone.now.beginning_of_day, Time.zone.now.end_of_month) }
  scope :past_months_foundations, lambda { where("start_date >= ? AND end_date <= ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_day) }
  # scope :upcomming_foundation, lambda { where("start_date >= ? AND end_date <= ?", Time.zone.now.end_of_day, Time.zone.now.end_of_month) }
  enum type_of_foundation: [ :community, :environment, :health, :animals, :faith, :other ]
  enum user_roles: [ :group_leader, :volunteer ]

  def full_address
    if self.city.present? && self.state.present?
      self.city.capitalize + ", " + self.state.upcase
    elsif self.city.present?
      self.city.capitalize
    else
      self.state.upcase
    end
  end

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    end
  end
end