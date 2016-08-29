class EmailMessagesController < ApplicationController
  respond_to :js,:json, :html
  # before_action :authorize, only: [:index]
  before_action :foundation_detail, only: [:index]

  def index
    @email_message = EmailMessage.new
    @email_message_recipients = EmailMessageRecipients.includes(:email_message).where(:email=> current_user.email)
    @current_user_message = EmailMessage.where("(user_id = ?  OR recipient_id = ?) AND parent_id IS ?", current_user.id, current_user.id, nil) if user_signed_in?
    @email_message_detail = current_user.email_messages  if user_signed_in? && current_user.email_messages.present?
    @user_friendrequests = Friendship.includes(:friend).where(:friend_id => current_user.id)
  end

  def email_message
    if params[:email].present? && params[:email_message].present?
      emails = params[:email].split(',') if params[:email].present?
      permitted_emails = User.where(email: emails, everyone_message_you: true).map(&:email)
      not_permitted_email = emails - permitted_emails
      if permitted_emails.present?
        permitted_emails.each do |email|
          recipient_id = User.find_by_email(email).id
          @email_message = current_user.email_messages.build(email_message_params)
          @email_message.recipient_id =  recipient_id
          if @email_message.save && not_permitted_email.present?
            flash[:alert] = "Email is successfully send to #{permitted_emails.join(",")} and  #{not_permitted_email.join(",")} Email ID is not permitted or does not exist.."
          else
            flash[:alert] = "Email is successfully send to #{permitted_emails.join(",")}.."
          end
        end
      else
        flash[:alert] = "#{not_permitted_email.join(",")} Email ID is not permitted or does not exist.."
      end
      redirect_to :back and return
    else
      flash[:alert] = "Someting Went Wrong"
      redirect_to :back and return
    end
  end

  def email_message_detail
    @email_message  = EmailMessage.find(params[:email_message_id]) if params[:email_message_id].present?
    @email_message_with_parent = EmailMessage.where('parent_id = ?', @email_message.id).order('id ASC')
    @email_message_id = params[:email_message_id] if params[:email_message_id].present?
    respond_to do |format|
      format.js
    end
  end

  def foundation_detail
    @foundation  = Foundation.find(params[:foundation_id]).user.email if params[:foundation_id].present?
  end

  def send_message_reply
    if params[:email_message_id].present?
      @message_id = params[:email_message_id]
      email_message  = EmailMessage.find(params[:email_message_id])
      parent = EmailMessage.where(subject:email_message.subject).first
      @message = current_user.email_messages.build(:parent_id => parent.id, :subject=> "#{email_message.subject}", :message=> params[:message]) if user_signed_in?
      if @message.valid?
        @message.save
        user = EmailMessage.find(@message.parent_id).user_id
        user_email = User.find(user).email
        @recipent_data = EmailMessageRecipients.new(:email=> user_email, :email_message_id => @message.id)
        if @recipent_data.valid?
          @recipent_data.save
        end
        respond_to do |format|
          format.js { render layout: false }
        end
      end
    end
  end

  def add_notification_message
    @email_message_with_parent = EmailMessage.where('parent_id = ?', @email_message.id).order('id ASC')
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  private

  def email_message_params
    params.require(:email_message).permit(:subject, :message, :recipient_id)
  end

  def authorize
    unless user_signed_in?
      redirect_to root_path
    end
  end
end
