json.set! :post_images do
  json.array! @post_images do |post_image|
    json.partial! "api/v1/post_images/post_image", post_image: post_image
    json.set! :user do
      json.partial! "api/v1/users/user", user: post_image.user
    end
  end
end

json.set! :following_user_images do
  json.array! @following_users_post_images do |post_image|
    json.partial! "api/v1/post_images/post_image", post_image: post_image
    json.set! :user do
      json.partial! "api/v1/users/user", user: post_image.user
    end
  end
end

json.set! :ranking_images do
  json.array! @ranking_post_images do |post_image|
    json.partial! "api/v1/post_images/post_image", post_image: post_image
    json.set! :user do
      json.partial! "api/v1/users/user", user: post_image.user
    end
  end
end

json.set! :ranking_illust_images do
  json.array! @post_images_illust do |post_image|
    json.partial! "api/v1/post_images/post_image", post_image: post_image
    json.set! :user do
      json.partial! "api/v1/users/user", user: post_image.user
    end
  end
end

json.set! :ranking_photo_images do
  json.array! @post_images_photo do |post_image|
    json.partial! "api/v1/post_images/post_image", post_image: post_image
    json.set! :user do
      json.partial! "api/v1/users/user", user: post_image.user
    end
  end
end

json.set! :ranking_logo_images do
  json.array! @post_images_logo do |post_image|
    json.partial! "api/v1/post_images/post_image", post_image: post_image
    json.set! :user do
      json.partial! "api/v1/users/user", user: post_image.user
    end
  end
end