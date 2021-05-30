json.set! :user do
  json.partial! "api/v1/users/user", user: @user
  json.follower(current_user.following?(@user))
end

json.set! :post_images do
  json.array! @post_images do |post_image|
    json.partial! "api/v1/post_images/post_image", post_image: post_image
    json.set! :user do
      json.partial! "api/v1/users/user", user: post_image.user
    end
  end
end

json.set! :favorite_images do
  json.array! @favorite_images do |post_image|
    json.partial! "api/v1/post_images/post_image", post_image: post_image
    json.set! :user do
      json.partial! "api/v1/users/user", user: post_image.user
    end
  end
end

json.set! :follower_images do
  json.array! @follower_images do |post_image|
    json.partial! "api/v1/post_images/post_image", post_image: post_image
    json.set! :user do
      json.partial! "api/v1/users/user", user: post_image.user
    end
  end
end