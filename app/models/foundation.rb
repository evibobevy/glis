class Foundation < ActiveRecord::Base
  has_many :foundation_pictures, :dependent => :destroy
  has_many :posts , :as => :postable
  belongs_to :user
  has_attached_file :image, :path => ":rails_root/public/images/:id/:filename", :url  => "/images/:id/:filename"
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  scope :today_foundation, lambda { where("start_date = ? ", Time.zone.now.beginning_of_day) }
  scope :latest_months_foundation, lambda { where("start_date >= ? AND end_date <= ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month) }
  scope :past_months_foundations, lambda { where("start_date >= ? AND end_date <= ?", Time.zone.now.beginning_of_month, Time.zone.now.beginning_of_day) }
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
end