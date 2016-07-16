class FriendshipsController < ApplicationController
    before_action :require_login

    def index
        @friendships = current_user.friendships.all 
    end

    def create
        @friendship = current_user.friendships.build(friend_id: params[:friend_id])

        if @friendship.cannot_add_yourself
            flash[:error] = "Friendship need 2 people"
            redirect_to root_path
        else
            if @friendship.save
                flash[:success] = "Added a friend"
                redirect_to root_path
            else
                flash[:error] = "Once friends, always friend"
                redirect_to root_path
            end
        end
    end

    def destroy
        @friendship = current_user.friendships.find_by(friend_id: params[:id])
        @friendship.destroy
        flash[:notice] = "You let a friend away"
        redirect_to root_path
    end
end
