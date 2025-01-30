class ChatsController < ApplicationController
  before_action :set_chat, only: [:show]

  def index
    @chats = Chat.where(sender: current_user).or(Chat.where(recipient: current_user))
    @chat = Chat.new  # Initialize @chat to prevent nil errors
    @users = User.where.not(id: current_user.id)  # Load users for selection
  end

  def show
    @messages = @chat.messages.order(created_at: :asc)
  end

  def new
  end

  def create
    recipient = User.find_by(id: params[:chat][:recipient_id])

    # Ensure the recipient exists
    if recipient.nil?
      flash[:alert] = "User not found."
      redirect_to chats_path and return
    end

    # Create or find an existing chat between current_user and the recipient
    @chat = Chat.find_or_create_by(sender: current_user, recipient: recipient)

    # If the chat is created successfully
    if @chat.persisted?
      # If a message was provided, send it
      if params[:message_content].present?
        @message = @chat.messages.create(content: params[:message_content], user: current_user)

        if @message.persisted?
          flash[:notice] = "Chat started and message sent."
        else
          flash[:alert] = "Message could not be sent."
        end
      else
        flash[:notice] = "Chat started without a message."
      end
      redirect_to @chat
    else
      flash[:alert] = "Could not start chat."
      redirect_to chats_path
    end
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
