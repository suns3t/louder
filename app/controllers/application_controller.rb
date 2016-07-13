class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :signed_in

  def current_user
    return User.find(session[:user_id]) if session[:user_id] else nil
  end

  def signed_in
    return true if session[:user_id] else false    
  end
end
