class UsersController < ApplicationController
    before_action :require_login, only: [:index]

    def new
        @user = User.new
    end

    def create
        @user = User.create user_params
        if @user.persisted?
            # Send out a sign up email
            UserNotifierMailer.send_signup_email(@user).deliver
            session[:user_id] = @user.id 
            flash[:success] = "You're in!"
            redirect_to root_path
        else
            flash[:notice] = "Ops, something wrong :("
            render "new" 
        end
    end

    def index
        # Load incoming messages for current user, mark them as read
        @messages = Message.where(recipient_id: current_user.id).order("created_at DESC")
    end

    private 
        def user_params
            params.require(:user).permit(:name, :email, :password)
        end
end
