class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  require_relative '../../config/initializers/twitter'
  protect_from_forgery with: :exception
  helper_method :hourly_offset

  OFFSET = 3600 # divide the utc offset by this to get it in single hour offsets

  def hourly_offset(utc_offset)
    utc_offset / OFFSET
  end

end
