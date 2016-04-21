class Event < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: :events_users
  has_many :posts
  has_attached_file :image, styles: { medium: "200x200#", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates :title,  :presence => true
  validates_attachment :image, presence: true
  validate :end_date_after_start_date?
  scope :this_months_event, lambda { where("event_date >= ? AND end_date <= ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month) }

  def end_date_after_start_date?
    if end_date < start_time
      errors.add :end_date, "must be after start date"
    end
  end

  before_save do
    self.event_date = self.start_time
  end
end
