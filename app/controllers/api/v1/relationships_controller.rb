class Api::V1::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user

  def get_user
    @user = User.find(params[:id])
  end

  def follow
    current_user.follow(params[:id])
    # @user.create_notification_follow(current_user, @user)
  end

  def unfollow
    current_user.unfollow(params[:id])
  end
end
