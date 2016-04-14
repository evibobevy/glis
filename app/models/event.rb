class Event < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: :events_users
  has_many :posts
  has_attached_file :image, styles: { medium: "200x200#", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates :title,  :presence => true
  validates_attachment :image, presence: true
end
