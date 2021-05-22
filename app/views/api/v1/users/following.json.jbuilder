json.set! :following_users do
  json.array! @followers do |user|
    json.partial! "api/v1/users/user", user: user
  end
end