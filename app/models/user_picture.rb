class UserPicture < ActiveRecord::Base
  belongs_to :user
  has_attached_file :image,
                    :path => ":rails_root/public/images/:id/:filename",
                    :url  => "/images/:id/:filename",
                    :styles => { large: "250x250#", medium: "200x200#", thumb: "100x100>" }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates :image, attachment_presence: true
end
