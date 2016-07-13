class SessionsController < ApplicationController
  def new
  end

  def create
    if @user = User.find_by(email: params[:email])
        if @user.authenticate(params[:password])
            # Validate sucessful email and password
            session[:user_id] = @user.id
            redirect_to users_path, notice: "Welcome back, #{@user.name}"
        else
            # Password is incorrect
            redirect_to "new", notice: "Oh no, wrong password!"
        end
    else
        # Email is incorrect
        redirect_to "new" , notice: "Ahh, not that email."        
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to users_path, notice: "You're out!"
  end
end
