class EmailMessage < ActiveRecord::Base
  belongs_to :user
  has_many :email_message_recipients, :class_name => "EmailMessageRecipients", :foreign_key => 'email_message_id', dependent: :destroy
  validates :message, :subject,:presence => true
  scope :by_parent_id, lambda { |parent_id| where('parent_id = ?', parent_id) }
end