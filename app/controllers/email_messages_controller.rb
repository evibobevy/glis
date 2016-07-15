class EmailMessagesController < ApplicationController
  respond_to :html,:js
  before_action :authenticate_user!, only: [:index]

  def index
    @email_message = EmailMessage.new
    @email_message_recipients = EmailMessageRecipients.includes(:email_message).where(:email=> current_user.email)
    @email_message_detail = EmailMessage.last
    @user_friendrequests = Friendship.includes(:friend).where(:friend_id => current_user.id)
  end

  def email_message
    emails = params[:email].split(',') if params[:email].present?
    permitted_emails = User.where(email: emails, everyone_message_you: true).map(&:email)
    not_permitted_email = emails - permitted_emails
    @email_message = current_user.email_messages.build(email_message_params)
    if @email_message.save
      permitted_emails.each do |email|
        @email_message.email_message_recipients.build(:email=> email)
        if @email_message.save
          flash[:success] = "Email Message saved"
        else
          flash[:error] = "Error occurred when Sending message."
        end
      end
      if not_permitted_email.present?
        flash[:alert] =  "This #{not_permitted_email.join("','")} is not permitted for email  "
      end
      redirect_to :back and return
    end
  end

  def email_message_detail
    @email_message  = EmailMessage.find(params[:email_message_id])
  end

  def send_message_reply
    if params[:email_message_id].present?
      email_message  = EmailMessage.find(params[:email_message_id])
      @message = current_user.email_messages.build(:parent_id => email_message.id, :subject=> "#{email_message.subject}", :message=> params[:message]) if user_signed_in?
      if @message.valid?
        @message.save
        user = EmailMessage.find(@message.parent_id).user_id
        user_email = User.find(user).email
        @recipent_data = EmailMessageRecipients.new(:email=> user_email, :email_message_id => @message.id)
        if @recipent_data.valid?
          @recipent_data.save
        end
        flash[:notice] = "Email Message saved"
        redirect_to :back and return
      else
        flash[:error] = "Error occurred when Sending message."
        redirect_to :back and return
      end
    end
  end

  private

  def email_message_params
    params.require(:email_message).permit(:subject, :message)
  end
end
