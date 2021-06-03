json.set! :post_images do
  json.array! @post_images do |post_image|
    json.extract! post_image, :id, :title
    image = post_image.encode_base64(post_image.post_image)
    json.post_image(image)
    json.set! :user do
      json.extract! post_image.user, :id, :user_name, :account_name
    end
  end
end

json.set! :following_user_images do
  json.array! @following_users_post_images do |post_image|
    json.extract! post_image, :id, :title
    image = post_image.encode_base64(post_image.post_image)
    json.post_image(image)
    json.set! :user do
      json.extract! post_image.user, :id, :user_name, :account_name
    end
  end
end

json.set! :ranking_images do
  json.array! @ranking_post_images do |post_image|
    json.extract! post_image, :id, :title
    image = post_image.encode_base64(post_image.post_image)
    json.post_image(image)
    json.set! :user do
      json.extract! post_image.user, :id, :user_name, :account_name
    end
  end
end

json.set! :ranking_illust_images do
  json.array! @post_images_illust do |post_image|
    json.extract! post_image, :id, :title
    image = post_image.encode_base64(post_image.post_image)
    json.post_image(image)
    json.set! :user do
      json.extract! post_image.user, :id, :user_name, :account_name
    end
  end
end

json.set! :ranking_photo_images do
  json.array! @post_images_photo do |post_image|
    json.extract! post_image, :id, :title
    image = post_image.encode_base64(post_image.post_image)
    json.post_image(image)
    json.set! :user do
      json.extract! post_image.user, :id, :user_name, :account_name
    end
  end
end

json.set! :ranking_logo_images do
  json.array! @post_images_logo do |post_image|
    json.extract! post_image, :id, :title
    image = post_image.encode_base64(post_image.post_image)
    json.post_image(image)
    json.set! :user do
      json.extract! post_image.user, :id, :user_name, :account_name
    end
  end
end

json.set! :hash_tags do
  json.array! @hash_tags do |hash_tag|
    json.extract! hash_tag, :id, :hashname
  end
end