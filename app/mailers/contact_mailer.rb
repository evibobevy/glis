class ContactMailer < ActionMailer::Base
  default from: "from@example.com"
  def contact_request(contact)
    @contact = contact
    mail(to: 'info@glis.org', subject: 'New Contact Submitted')
  end
  def contact_notification_mail(contact)
    @contact = contact
    mail(to: @contact[:email], subject: 'Contact Request Notification Email')
  end
end
