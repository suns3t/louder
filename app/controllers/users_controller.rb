class UsersController < ApplicationController
    before_action :require_login, only: [:index]

    def new
        @user = User.new
    end

    def create
        @user = User.create user_params
        if @user.persisted?
            session[:user_id] = @user.id 
            redirect_to root_path, notice: "You're in!"
        else
            render "new", notice: "Ops, something wrong :("
        end
    end

    def index
        @users = User.all 
    end

    private 
        def user_params
            params.require(:user).permit(:name, :email, :password)
        end
end
