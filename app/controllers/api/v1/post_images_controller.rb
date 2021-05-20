class Api::V1::PostImagesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :main, :create, :update]

  def show
    @post_image = PostImage.find(params[:id])
    @user = @post_image.user
    @post_comments = @post_image.post_comments.order(id: "DESC")
  end

  def index
    @post_images = PostImage.preload(:user).all.order(id: "DESC")
    @post_images_illust = (@post_images.select { |n| n.post_image_genre === "イラスト"})
    @post_images_photo = (@post_images.select { |n| n.post_image_genre === "写真"})
    @post_images_logo = (@post_images.select { |n| n.post_image_genre === "ロゴ"})
  end

  def main
    @post_images = PostImage.preload(:user).sort_new(15)
    @following_users_post_images = PostImage.preload(:user).my_follower_img(current_user).sort_new(15) if user_signed_in?
    @hash_tags = HashTag.find(PostImageHashtagRelation.group(:hash_tag_id).sort_favorite(:hash_tag_id, 20).pluck(:hash_tag_id))
    ranking_post_images = PostImage.preload(:user).find(Favorite.group(:post_image_id).sort_favorite(:post_image_id))
    @ranking_post_images = ranking_post_images.first(15)
    @post_images_illust = (ranking_post_images.select { |n| n.post_image_genre === "イラスト" }).first(15)
    @post_images_photo = (ranking_post_images.select { |n| n.post_image_genre === "写真" }).first(15)
    @post_images_logo = (ranking_post_images.select { |n| n.post_image_genre === "ロゴ" }).first(15)
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

  def hashtag
    @tag = HashTag.find_by(hashname: params[:name])
    @post_images = @tag.post_images.preload(:user)
  end

  private
    def post_image_params
      params.require(:post_image).permit(:title, :image_introduction, :image, :post_image_genre)
    end
end
