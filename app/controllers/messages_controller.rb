class MessagesController < ApplicationController
    def create
      @chat = Chat.find(params[:chat_id])  # Find the chat from the URL
      @message = @chat.messages.build(message_params)  # Build a new message associated with the chat
      @message.user = current_user  # Set the user as the sender

      if @message.save
        redirect_to @chat, notice: "Message sent!"  # Redirect to the chat show page after saving
      else
        flash[:alert] = "Message could not be sent."  # Display an error message if saving fails
        redirect_to @chat  # Stay on the chat page
      end
    end

    private

    def message_params
      params.require(:message).permit(:content)  # Only permit the content attribute, no need for chat_id
    end
end
