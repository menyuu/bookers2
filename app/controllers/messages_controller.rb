class MessagesController < ApplicationController
  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      room = Room.find(params[:message][:room_id])
      @messages = room.messages
      @entries = room.entries
      @not_current_user = Entry.where.not(user_id: current_user).where(room_id: room.id)
      @message = Message.create(message_params)
      # redirect_to room_path(@message.room_id)
      render "rooms/create"
    else
      flash[:notice] = "メッセージの送信に失敗しました。"
      render "rooms/show"
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :room_id, :message).merge(user_id: current_user.id)
  end
end
