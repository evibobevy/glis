class Volunteer < ActiveRecord::Base
  # has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  has_attached_file :image,
                    :styles => { medium: "300x300>", thumb: "100x100>" },
                    :storage        => :s3,
                    :s3_host_name   => 's3-us-west-2.amazonaws.com',
                    :path           => "#{Rails.env}/volunteers/:id/:style/:filename",
                    :s3_region      => 'us-west-2',
                    :s3_protocol    => :https,
                    :s3_credentials => YAML.load_file("#{Rails.root}/config/aws.yml"),
                    :default_url    => '/assets/stayIcon.png'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
