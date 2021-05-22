class Api::V1::ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_request_user, only: [:show]

  def show
    if current_user === @request.requested
      @user = @request.requester
    elsif current_user === @request.requester
      @user = @request.requested
    end
    rooms = current_user.user_rooms
    request_room = rooms.find_by(request_id: params[:request_id])
    if request_room.nil?
      room = @request
      UserRoom.create(user_id: current_user.id, request_id: @request.id)
      UserRoom.create(user_id: @user.id, request_id: @request.id)
    else
      user_room = UserRoom.find_by(user_id: @user.id, request_id: @request.id)
      room = user_room.request
    end
    @chats = room.chats
  end

  def create
    chat = current_user.chats.new(chat_params)
    if chat.save
      # @chat.create_notification_chat(current_user)
      render json: chat, status: :created
    else
      render json: chat.errors, status: :unprocessable_entity
    end
  end

  def destroy
    chat = Chat.find(params[:id])
    if chat.destroy
      head :no_content
    else
      render json: chat.errors, status: :unprocessable_entity
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :request_id)
  end

  def ensure_request_user
    @request = Request.find(params[:request_id])
    if current_user != @request.requester && current_user != @request.requested
      redirect_to main_post_images_path, alert: "メッセージ画面はリクエストユーザー同士以外は閲覧することはできません"
    end
  end
end
