class ContactRequest < ActiveRecord::Base
  validates_presence_of :name, :email, :company_name, :phone_number, :description

  after_save :send_notification
  private

  def send_notification
    ContactMailer.contact_request(self).deliver
    ContactMailer.contact_notification_mail(self).deliver
  end
end
