class SessionsController < ApplicationController
  before_action :skip_if_logged_in, only: [:new, :create]

  def new
  end

  def callback
    if @user = User.from_omniauth(request.env['omniauth.auth'])
        # log in user
        session[:user_id] = @user.id
        redirect_to users_path, info: "Welcome to Louder, #{@user.name}"
    else
        # don't log user in
        redirect_to 'new', notice: "You cannot log in from Facebook"

    end
  end
  def create
      if @user = User.find_by(email: params[:email])
        if @user.authenticate(params[:password])
            # Validate sucessful email and password
            session[:user_id] = @user.id
            redirect_to users_path, notice: "Welcome back, #{@user.name}"
        else
            # Password is incorrect
            flash[:error] = "Oh no, wrong password!"
            render "new"
        end
      else
          # Email is incorrect
          flash[:error] = "Ahh, not that email."        
          render "new"
      end
  end

  def destroy
      session[:user_id] = nil
      redirect_to users_path, notice: "You're out!"
  end
end
