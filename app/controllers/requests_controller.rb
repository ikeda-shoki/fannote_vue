class RequestsController < ApplicationController
  # before_action :authenticate_user!, only: [:main, :show]
  # before_action :ensure_request_user, only: [
  #   :requesting_show,
  #   :requested_show,
  #   :request_done,
  #   :request_complete,
  # ]
  # before_action :ensure_request_current_user, only: [:requesting, :requested]
  # before_action :ensure_request_requester, only: [:request_complete]
  # before_action :ensure_request_requested, only: [:request_done]

  def requesting
  end

  def requested
  end

  # 依頼終了画面
  def request_done
  end

  # 依頼完了画面
  def request_complete
  end

  private
    def ensure_request_user
      @request = Request.find(params[:id])
      if current_user != @request.requester && current_user != @request.requested
        redirect_to main_post_images_path, alert: '注文に関するページへは関係者以外接続することはできません'
      end
    end

    def ensure_request_current_user
      @user = User.find_by(id: params[:user_id])
      unless @user === current_user
        redirect_to main_post_images_path, alert: '注文一覧ページへは本人以外接続することはできません'
      end
    end

    def ensure_request_requester
      unless @request.requester === current_user
        redirect_to main_post_images_path, alert: '完成したイラストは発注関係者以外は閲覧できません'
      end
    end

    def ensure_request_requested
      unless @request.requested === current_user
        redirect_to main_post_images_path, alert: '完成したイラストは発注関係者以外は閲覧できません'
      end
    end
end
