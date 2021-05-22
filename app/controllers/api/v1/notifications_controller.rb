class Api::V1::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    notifications_type = [:visitor, :visited, :request, :post_image]
    @notifications = current_user.passive_notifications.includes(notifications_type).all.order(created_at: :desc)
    @notifications.checked.each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy
    notification = Notification.find(params[:id])
    if notification.destroy
      head :no_content
    else
      render json: notification.errors, status: :unprocessable_entity
    end
  end

  def all_destroy
    user_notifications = Notification.where(visited_id: current_user.id)
    user_notifications.destroy_all
    @notifications = current_user.passive_notifications.all
  end
end
