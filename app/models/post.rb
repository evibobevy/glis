class Post < ActiveRecord::Base
  has_many  :comments, dependent: :destroy
  belongs_to :user
  belongs_to :event
  belongs_to :postable, :polymorphic => true
  validates :name,  :presence => true

  def self.event_posts
    where(postable_type:'Event')
  end
  def self.foundation_posts
    where(postable_type:'Foundation')
  end
end
