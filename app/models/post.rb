class Post < ActiveRecord::Base
  has_many  :comments, dependent: :destroy
  belongs_to :user
  belongs_to :event
  validates :name,  :presence => true
end
