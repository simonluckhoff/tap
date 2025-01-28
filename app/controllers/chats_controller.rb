class ChatsController < ApplicationController
  before_action :set_chat, only: [:show]

  def index
    # Show all chats involving the current user
    @chats = Chat.where(sender: current_user).or(Chat.where(recipient: current_user))
  end

  def show
    # Display the specific chat and its messages
    @messages = @chat.messages.order(created_at: :asc)
  end

  def new
  end

  def create
    @chat = Chat.new
    @recipient = User.find(params[:recipient_id])
    @chat.sender = current_user
    @chat.recipient = @recipient
    @chat.save
    redirect_to @chat
  end

  def create_message
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.build(content: params[:content], user: current_user)

    if @message.save
      redirect_to @chat
    else
      flash[:alert] = "Message could not be sent."
      render :show
    end
  end

  private

  def set_chat
    @chat = Chat.find(params[:id])
  end
end
