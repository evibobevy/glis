class ContactMailer < ActionMailer::Base
  default from: "from@example.com"
  def contact_request(contact)
    @contact = contact
    mail(to: 'demo9392@gmail.com', subject: 'New Contact Submitted')
  end
  def contact_notification_mail(contact)
    @contact = contact
    mail(to: @contact[:email], subject: 'Contact Request Notification Email')
  end
end
