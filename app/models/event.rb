class Event < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: :events_users
  has_many :posts
  has_many :pictures, :dependent => :destroy
  has_attached_file :image, styles: { medium: "200x200#", thumb: "100x100>" }
  #validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates :title,  :presence => true
  validate :validate_git_start_date
  validate :validate_gig_end_date
  scope :latest_months_event, lambda { where("event_date >= ? AND end_date <= ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month) }
  scope :today_event, lambda { where("event_date = ? ", Time.zone.now.beginning_of_day) }
  scope :by_year, lambda { |year| where('extract(year from event_date) = ?', year) }
  scope :by_month, lambda { |year| where('extract(month from event_date) = ?', month) }

  enum type_of_gig: [ :community, :environment, :health, :animals, :faith, :other ]
  enum user_roles: [ :group_leader, :volunteer ]

  def validate_git_start_date
    errors.add("Gig at date", "is invalid.") unless event_date
  end

  def validate_gig_end_date
    errors.add("Gig at date", "is invalid.") unless end_date
  end

  # def end_date_after_start_date?
  #   if end_date < start_time
  #     errors.add :end_date, "must be after start date"
  #   end
  # end

  before_save do
    self.start_time = self.event_date
  end
end
