class Api::V1::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user

  def get_user
    @user = User.find(params[:id])
  end

  def follow
    if !current_user.following?(@user)
      current_user.follow(params[:id])
      @user.create_notification_follow(current_user, @user)
      render json: @user.followed_user.count, status: :ok
    else
      redirect_to main_post_images_path
    end
  end

  def unfollow
    if current_user.following?(@user)
      current_user.unfollow(params[:id])
      render json: @user.followed_user.count, status: :ok
    else
      redirect_to main_post_images_path
    end
  end
end
