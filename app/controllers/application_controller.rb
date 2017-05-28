class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin_or_staff?
    current_user && (current_user.admin? || current_user.staff?)
  end

  def require_admin_or_staff
    render file: "/public/404" unless current_admin_or_staff?
  end
end
