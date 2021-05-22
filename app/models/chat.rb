class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :request

  validates :message, presence: { message: "メッセージ送信欄が空白です。" }

  def create_notification_chat(current_user)
    requests = request.user_rooms
    visited_user_room = requests.find_by('user_id != ?', current_user.id)
    notification = current_user.active_notifications.new(
      visitor_id: current_user.id,
      visited_id: visited_user_room.user_id,
      request_id: request.id,
      action: 'chat'
    )
    notification.save
  end
end
