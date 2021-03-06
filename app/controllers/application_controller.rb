class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  config.time_zone = 'Eastern Time (US & Canada)'
  skip_before_action :protect_from_forgery
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  # helper_method :mobile_device?

  private

  def record_not_found
      redirect_to root_path
  end

  # def mobile_device?
  #   p "======================="
  #   p request.user_agent
  #   (request.user_agent =~ /Mobile/) != -1
  # end
end