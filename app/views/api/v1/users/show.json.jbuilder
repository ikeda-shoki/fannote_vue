json.set! :user do
  json.partial! "api/v1/users/user", user: @user
end

json.set! :post_images do
  json.array! @user.post_images do |post_image|
    json.partial! "api/v1/post_images/post_image", post_image: post_image
  end
end