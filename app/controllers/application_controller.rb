class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  skip_before_action :protect_from_forgery
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  # before_filter :set_time_zone, if: :user_signed_in?
  #
  # private
  # def set_time_zone(&block)
  #   Time.use_zone(current_user.time_zone, &block)
  # end
end