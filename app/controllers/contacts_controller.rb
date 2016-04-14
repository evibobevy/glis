class ContactsController < ApplicationController
  layout "fancybox", :only => [:new,:create]
  def new
    @contact = ContactRequest.new
  end

  def contact
    @contact = ContactRequest.new(contact_params)
    if request.post?
      if @contact.valid?
        @contact.save
        flash[:notice] = "Thank you for your interest to contact us!"
        #redirect_to root_path
      else
        @error_message = error_messages(@contact)
        @error_message ||= 'Unable to create new address.'
      end
      respond_to do |format|
        format.js { render layout: false }
      end
    end
  end

  def error_messages(record)
    return nil unless record.errors
    record.errors.full_messages.map { |msg| msg }.join('<br />')
  end

  private
  def contact_params
    params.require(:contact_request).permit(:name, :email, :company_name , :phone_number, :description, :captcha_code)
  end
end
