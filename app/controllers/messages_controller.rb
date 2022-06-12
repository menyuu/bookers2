class MessagesController < ApplicationController

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
       @message = Message.create(message_params)
       redirect_to room_path(@message.room_id)
     else
       flash[:notice] = "メッセージの送信に失敗しました。"
       render "rooms/show"
    end
  end


  private

 private
 def message_params
   params.require(:message).permit(:user_id, :room_id, :message).merge(user_id: current_user.id)
 end

end
