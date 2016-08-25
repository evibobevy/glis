class UserPicture < ActiveRecord::Base
  belongs_to :user
  has_attached_file :image,
                    :path => ":rails_root/public/images/:id/:style/:filename",
                    :url  => "/images/:id/:style/:filename",
                    :styles => { large: "250x250#", medium: "184x128#", thumb: "100x100>" }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates :image, attachment_presence: true
end
