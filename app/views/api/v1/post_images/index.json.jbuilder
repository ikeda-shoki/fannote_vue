json.set! :post_images do
  json.array! @post_images do |post_image|
    json.partial! "api/v1/post_images/post_image", post_image: post_image
    json.set! :user do
      json.extract! post_image.user, :id, :user_name, :account_name
    end
  end
end

json.set! :post_images_illust do
  json.array! @post_images_illust do |post_image|
    json.partial! "api/v1/post_images/post_image", post_image: post_image
    json.set! :user do
      json.extract! post_image.user, :id, :user_name, :account_name
    end
  end
end

json.set! :post_images_photo do
  json.array! @post_images_photo do |post_image|
    json.partial! "api/v1/post_images/post_image", post_image: post_image
    json.set! :user do
      json.extract! post_image.user, :id, :user_name, :account_name
    end
  end
end

json.set! :post_images_logo do
  json.array! @post_images_logo do |post_image|
    json.partial! "api/v1/post_images/post_image", post_image: post_image
    json.set! :user do
      json.extract! post_image.user, :id, :user_name, :account_name
    end
  end
end