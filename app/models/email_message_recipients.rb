class EmailMessageRecipients < ActiveRecord::Base
  belongs_to :email_message,  :class_name => "EmailMessage", :foreign_key => 'email_message_id'
end











