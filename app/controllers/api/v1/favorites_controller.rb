class Api::V1::FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @post_image = PostImage.find(params[:post_image_id])
    favorite = current_user.favorites.new(post_image_id: @post_image.id)
    if favorite.save
      @post_image.create_notification_favorite(current_user)
      render json: favorite, status: :created
    else
      render json: favorite.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post_image = PostImage.find(params[:post_image_id])
    favorite = current_user.favorites.find_by(post_image_id: @post_image.id)
    if favorite.destroy
      render json: favorite, staus: :delete
    else
      render json: favorite.errors, status: :unprocessable_entity
    end
  end
end
