class Picture < ActiveRecord::Base
  belongs_to :event
  has_attached_file :image,
                    :path => ":rails_root/public/images/:id/:filename",
                    :url  => "/images/:id/:filename"
  # validates_attachment_content_type :image, :content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
