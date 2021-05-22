class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_request_user, only: [:show]

  def show
  end

  private

  def ensure_request_user
    @request = Request.find(params[:request_id])
    if current_user != @request.requester && current_user != @request.requested
      redirect_to main_post_images_path, alert: "メッセージ画面はリクエストユーザー同士以外は閲覧することはできません"
    end
  end
end
