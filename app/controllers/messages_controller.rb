class MessagesController < ApplicationController
    helper_method :load_conversation

    def new
        # allow user to write a new message to a recipient in his friend list
        @recipient_list = current_user.friendships.collect{ |friendship| [User.find(friendship.friend_id).to_string, friendship.friend_id]}
    end

    def create
        # crate a message goes here
        @message = Message.new(message_params)
        @message.sender_id = current_user.id

        if @message.save
            flash[:notice] = "Message is sent."
            redirect_to :back
        else
            flash[:error] = "Cannot send message"
            render 'new'
        end
    end 

    def index
        # List all message sent from current user
        @messages = Message.where(sender_id: current_user.id)
    end

    def destroy
        # some logic goes here
        @message = Message.find(params[:id])

        if (params[:user_id].to_i == current_user.id)
            @message.destroy
            flash[:success] = "Message is removed"
            redirect_to 'index'
        else
            byebug
            flash[:error] = "You cannot delete others' message"
            redirect_to :back
        end
    end 

    def load_conversation(sender_id, recipient_id)
        Message.where("(sender_id = ? AND recipient_id = ?) OR (sender_id = ? AND recipient_id = ?)", sender_id, recipient_id, recipient_id, sender_id).order("created_at DESC")
    end

    private 
        def message_params
            params.permit(:recipient_id, :body)
        end
end
