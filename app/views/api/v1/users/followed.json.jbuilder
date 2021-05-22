json.set! :followed_users do
  json.array! @followed do |user|
    json.partial! "api/v1/users/user", user: user
  end
end