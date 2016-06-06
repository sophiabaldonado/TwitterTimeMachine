class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  require_relative '../../config/initializers/twitter'
  protect_from_forgery with: :exception
  helper_method :current_user, :user_favorited?
  # before_action :require_login

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
    if current_user.nil?
      flash[:error] = "You must be logged in to view this section"
      redirect_to '/auth/spotify'
    end
  end

end
