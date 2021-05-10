json.set! :current_user do
  json.partial! "api/v1/users/user", user: @user
end

json.sign_in(user_signed_in?)