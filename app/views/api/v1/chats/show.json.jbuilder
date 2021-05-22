json.set! :chats do
  json.array! @chats do |chat|
    json.extract! chat, :id, :message, :user_id
    json.set! :user do
      json.partial! "api/v1/users/user", user: chat.user
    end
  end
end

json.set! :request_other_user do
  json.partial! "api/v1/users/user", user: @user
end