if user_signed_in?
  json.set! :current_user do
    json.partial! "api/v1/users/user", user: @current_user
    json.unchecked_notifications(@current_user.unchecked_notifications?)
  end
else
  json.set! :current_user do
    json.id("")
  end
end

json.sign_in(user_signed_in?)