class Picture < ActiveRecord::Base
  belongs_to :event
  # has_attached_file :image,
  #                   :path => ":rails_root/public/images/:id/:filename",
  #                   :url  => "/images/:id/:filename"
  has_attached_file :image,
                    :styles => {  small:"181x160#" },
                    :storage        => :s3,
                    :s3_host_name   => 's3-us-west-2.amazonaws.com',
                    :path           => "#{Rails.env}/pictures/:id/:style/:filename",
                    :s3_region      => 'us-west-2',
                    :s3_protocol    => :https,
                    :s3_credentials => YAML.load_file("#{Rails.root}/config/aws.yml"),
                    :default_url    => '/assets/stayIcon.png'
  # validates_attachment_content_type :image, :content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
