class Api::V1::PostImagesController < ApplicationController
  def show
    post_image = PostImage.find(params[:id])
    image = post_image.post_image
    if image.present?
      post_image['image'] = encode_base64(image)
    end
    render json: post_image
  end

  def main
    post_images = PostImage.all
    render json: post_images
  end

  def create
    post_image = PostImage.new(post_image_params)
    if post_image.save
      post_image.parse_base64(params[:image])
      render json: post_image, status: :created
    else
      render json: post_image.errors, status: :unprocessable_entity
    end
  end

  private
    def post_image_params
      params.permit(:title, :image_introduction, :image, :post_image_genre, :user_id).merge(user_id: current_user.id)
    end
end
