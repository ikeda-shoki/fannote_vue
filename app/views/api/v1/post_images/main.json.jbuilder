json.set! :post_images do
  json.array! @post_images do |post_image|
    json.extract! post_image, :id, :title, :image_introduction, :post_image_genre
    json.user_name(post_image.user.user_name)
    json.account_name(post_image.user.account_name)
    if post_image.post_image.attached?
      image = post_image.encode_base64(post_image.post_image)
    end
    json.post_image(image)
  end
end