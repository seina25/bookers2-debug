class MessagesController < ApplicationController


  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).any?
      @message = Message.create((message_params).merge(user_id: current_user.id))
      flash[:notice] = "You have created book successfully."
      redirect_back(fallback_location: root_path)
    else
      render 'rooms/show'
    end
  end

  private
  def message_params
    params.require(:message).permit(:user_id, :message, :room_id)
  end
end