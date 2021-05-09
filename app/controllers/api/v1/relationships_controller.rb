class Api::V1::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user

  def get_user
    @user = User.find(params[:id])
  end

  def follow
    current_user.follow(params[:id])
    render json: @user.following_user.count, status: :ok
    # @user.create_notification_follow(current_user, @user)
  end

  def unfollow
    current_user.unfollow(params[:id])
    render json: @user.following_user.count, status: :ok
  end
end
