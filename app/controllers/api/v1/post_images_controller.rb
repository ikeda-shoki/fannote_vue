class Api::V1::PostImagesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :main, :create, :update]

  def show
    @post_image = PostImage.find(params[:id])
    @user = @post_image.user
    @post_comments = @post_image.post_comments.order(id: "DESC")
  end

  def main
    @post_images = PostImage.all
  end

  def create
    post_image = PostImage.new(post_image_params)
    post_image.user_id = current_user.id
    post_image.parse_base64(params[:post_image][:image])
    if post_image.save
      render json: post_image, status: :created
    else
      render json: post_image.errors, status: :unprocessable_entity
    end
  end

  def update
    # post_image.rbでbefore_updateを使用して＃を1から追加する
    post_image = PostImage.find(params[:id])
    post_image.parse_base64(params[:post_image][:image])
    if post_image.update(post_image_params)
      render json: post_image, status: :ok
    else
      render json: post_image.errors, status: :unprocessable_entity
    end
  end

  def destroy
    post_image = PostImage.find(params[:id])
    if post_image.destroy
      render json: post_image, staus: :delete
    else
      render json: post_image.errors, status: :unprocessable_entity
    end
  end

  private
    def post_image_params
      params.require(:post_image).permit(:title, :image_introduction, :image, :post_image_genre)
    end
end
