class Post < ActiveRecord::Base
  has_many  :comments, dependent: :destroy
  belongs_to :user
  belongs_to :event
  validates :name,  :presence => true
  # validate :checkpost, :on => :create

  # def checkpost
  #   if  self.name.blank?.inspect
  #     errors.add(:name, "can't be in the blank")
  #   end
  # end
end
