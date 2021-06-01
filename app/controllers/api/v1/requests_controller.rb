class Api::V1::RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_request_user, only: [
    :requesting_show,
    :requested_show,
    :request_done,
    :request_complete,
    :update,
    :update_request_status,
    :update_request_complete_image,
    :destroy,
  ]
  before_action :ensure_request_current_user, only: [:requesting, :requested]
  before_action :ensure_request_requester, only: [:update, :destroy, :request_complete]
  before_action :ensure_request_requested, only: [:update_request_status, :update_request_complete_image, :request_done]

  # 自分の依頼一覧画面
  def requesting
    @requests = @user.request.preload(:requested)
  end

  # 自分に来ている依頼
  def requested
    @requests = @user.requested.preload(:requester)
  end

  # 依頼終了画面
  def request_done
  end

  # 依頼完了画面
  def request_complete
  end

  def create
    user = User.find(params[:user_id])
    request = Request.new(request_params)
    if (params[:request][:image]).present?
      request.parse_base64(params[:request][:image])
    end
    request.requested_id = user.id
    if request.save
      request.create_notification_request(current_user)
      render json: request, status: :created
    else
      render json: request.errors, status: :unprocessable_entity
    end
  end

  def update
    if @request.reference_image.attached?
      # 画像が登録されている場合
      if @request.update(request_params)
        if (params[:request][:image]).present?
          @request.parse_base64(params[:request][:image])
          image = @request.encode_base64(@request.reference_image)
          render json: { request: @request, reference_image: image }, status: :ok
        else
          @request.reference_image.purge
          render json: { request: @request, reference_image: "" }, status: :ok
        end
      else
        render json: @request.errors, status: :unprocessable_entity
      end
    else
      # 画像が登録されていない場合
      if @request.update(request_params)
        if (params[:request][:image]).present?
          @request.parse_base64(params[:request][:image])
          image = @request.encode_base64(@request.reference_image)
          render json: { request: @request, reference_image: image }, status: :ok
        else
          render json: { request: @request, reference_image: "" }, status: :ok
        end
      else
        render json: @request.errors, status: :unprocessable_entity
      end
    end
  end

  # request_statusのみの更新
  def update_request_status
    if @request.update(request_update_params)
      @request.create_notification_request_status(current_user)
      render json: @request, status: :ok
    else
      render json: @request.errors, status: :unprocessable_entity
    end
  end

  # 完成した画像を登録する際に使用
  def update_request_complete_image
    if @request.request_images.attached?
      #すでに画像が登録されている場合
      @request.request_images.purge
      if @request.parse_base64s(params[:request][:request_images]) && @request.valid?(:update_complete_image)
        if @request.amount === @request.request_images.size
          @request.update(request_status: :"製作完了")
          @request.requested.increment!(:complete_request_count, 1)
          render json: @request, status: :ok
          return
        end
        @request.create_notification_request_status(current_user)
        render json: @request, status: :ok
      else
        render json: @request.errors, status: :unprocessable_entity
      end
    else
      #初めての画像投稿の場合
      if @request.parse_base64s(params[:request][:request_images]) && @request.valid?(:update_complete_image)
        if @request.amount === @request.request_images.size
          @request.update(request_status: :"製作完了")
          @request.requested.increment!(:complete_request_count, 1)
          render json: @request, status: :ok
          return
        end
        @request.create_notification_request_status(current_user)
        render json: @request, status: :ok
      else
        render json: { request_images: [ "画像を選択してください" ]}, status: :unprocessable_entity
        @request.request_images.purge
      end
    end
  end

  def destroy
    if @request.destroy
      head :no_content
    else
      render json: @request.errors, status: :unprocessable_entity
    end
  end

  private

  def request_params
    params.require(:request).permit(:request_introduction,
                                    :image,
                                    :file_format,
                                    :use,
                                    :deadline,
                                    :amount,
                                    :requester_id).merge(requester_id: current_user.id)
  end

  def request_update_params
    params.require(:request).permit(:request_status)
  end

  def complete_image_update_params
    params.require(:request).permit(request_images: [])
  end

  def ensure_request_user
    @request = Request.find(params[:id])
    if current_user != @request.requester && current_user != @request.requested
      redirect_to main_post_images_path, alert: '注文に関するページへは関係者以外接続することはできません'
    end
  end

  def ensure_request_current_user
    @user = User.find(params[:id])
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
