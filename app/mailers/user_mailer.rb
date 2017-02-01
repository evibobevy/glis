class UserMailer < ActionMailer::Base
  default from: "demo9392@gmail.com"
  helper EmailMessagesHelper

  def user_notification(user, friend_id)
    @user = user
    @friend_id = friend_id
    mail(to:@user.email, subject: 'Notification Email')
  end
end
