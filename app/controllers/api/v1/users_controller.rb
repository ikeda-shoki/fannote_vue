class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :index, :update, :following, :followed]
  before_action :ensure_current_user, only: [:edit, :update, :destroy]

  def sign_in
    @current_user = current_user
  end

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.order(id: "DESC")
    favorites = Favorite.favorite_post_image(@user.id)
    @favorite_images = PostImage.preload(:user).find(favorites.reverse)
    @follower_images = PostImage.preload(:user).following_img(@user.following_user)
  end

  def index
    @users = User.all.order(id: "DESC")
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      if (params[:user][:image]).present?
        user.parse_base64(params[:user][:image])
        render json: user, status: :ok
      else
        user.profile_image.purge
        render json: user, status: :ok
      end
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def following
    @user = User.find(params[:id])
    @followers = @user.following_user
  end

  def followed
    @user = User.find(params[:id])
    @followed = @user.followed_user
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :account_name, :user_introduction, :image, :is_reception)
  end

  def ensure_current_user
    user = User.find(params[:id])
    unless user === current_user
      redirect_to user_path(current_user)
    end
  end
end