class UserPicture < ActiveRecord::Base
  belongs_to :user
  # has_attached_file :image,
  #                   :path => ":rails_root/public/images/:id/:style/:filename",
  #                   :url  => "/images/:id/:style/:filename",
  #                   :styles => { large: "250x250#", medium: "184x128#", thumb: "100x100>" }
  # validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  # validates :image, attachment_presence: true
  has_attached_file :image,
                    :styles => { large: "250x250#", medium: "184x128#", thumb: "100x100>" },
                    :storage        => :s3,
                    :s3_host_name   => 's3-us-west-2.amazonaws.com',
                    :path           => "#{Rails.env}/user_pictures/:id/:style/:filename",
                    :s3_region      => 'us-west-2',
                    :s3_credentials => YAML.load_file("#{Rails.root}/config/aws.yml"),
                    :default_url    => '/assets/noImg.jpg'

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates :image, attachment_presence: true
end
