class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :ensure_current_user, only: [:edit, :update, :destroy]

  def sign_in
    sign_in = user_signed_in?
    user = current_user
    render json: { signIn: sign_in, curretUser: user }
  end

  def show
    @user = User.find(params[:id])
    @current_user_sign_in = @user.current_user_sign_in?(current_user)
    @count = @user.post_images.count
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      user.parse_base64(params[:user][:image])
      render json: user, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
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