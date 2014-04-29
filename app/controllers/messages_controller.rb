class MessagesController < ApplicationController
  before_action :find_message, except: [:create, :index]

  def index
    @resieved_messages = current_user.recieved_messages.order(created_at: :desc)
    @sent_messages = current_user.sent_messages.order(created_at: :desc)
    @new_message = Message.new
  end

  def create
    if @message = current_user.sent_messages.create(message_params)
      redirect_to User.find(@message.recipient_id)
      flash[:notice] = "Message was successfully sent to #{User.find(@message.recipient_id).fullname}"
    else
      flash[:notice] = "Message was not sent. Please check, is all fields not empty."
    end
  end

  def mark_as_read
    @message.read = true
    respond_to do |format|
      if @message.save
        format.js { render json: { success: true }  }
      end
    end
  end

  def update
    if @message.update_attributes!(message_update_params)
      flash[:notice] = "You have been mark as read message #{@message.theme}."
    else
      flash[:notice] = "Sorry. An erroe occupied while mark as read."
    end
    redirect_to messages_path
  end

  def destroy
    @message.destroy
    redirect_to messages_path
  end

  private

  def find_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:sender_id, :recipient_id, :theme, :content)
  end

  def message_update_params
    params.fetch(:message, {}).permit(:read)
  end
end
