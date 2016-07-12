class Post < ActiveRecord::Base
  has_many  :comments, dependent: :destroy
  belongs_to :user
  belongs_to :event
  belongs_to :foundation
  belongs_to :postable, :polymorphic => true
  validates :name,  :presence => true
end
