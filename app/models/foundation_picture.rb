class FoundationPicture < ActiveRecord::Base
  belongs_to :foundation
  # has_attached_file :image,
  #                   :path => ":rails_root/public/images/:id/:filename",
  #                   :url  => "/images/:id/:filename",
  #                   :styles => { large: "250x250#", medium: "200x200#", thumb: "100x100>" }
  has_attached_file :image,
                    :styles => { large: "250x250#", medium: "200x200#", thumb: "100x100>" },
                    :storage        => :s3,
                    :s3_host_name   => 's3-us-west-2.amazonaws.com',
                    :path           => "#{Rails.env}/foundation_pictures/:id/:style/:filename",
                    :s3_region      => 'us-west-2',
                    :s3_credentials => YAML.load_file("#{Rails.root}/config/aws.yml"),
                    :default_url    => '/assets/stayIcon.png'
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates :image, attachment_presence: true
end
