json.set! :notifications do
  json.array! @notifications do |notification|
    json.extract! notification, :id, :visitor_id, :visited_id, :post_image_id, :request_id, :action, :checked, :created_at
    json.set! :visitor do
      json.partial! "api/v1/users/user", user: notification.visitor
    end
    json.set! :visited do
      json.partial! "api/v1/users/user", user: notification.visited
    end
    json.time_ago(time_ago_in_words(notification.created_at))
  end
end