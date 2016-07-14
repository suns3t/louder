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

    def require_login
        if session[:user_id]
            true
        else
            redirect_to login_path, notice: "Please login to see, plz!" 
        end 

    end

    def skip_if_logged_in
        if session[:user_id]
            redirect_to users_path
        end
    end
end
