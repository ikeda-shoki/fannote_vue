json.set! :post_image do
  json.extract! @post_image, :id, :title, :image_introduction, :post_image_genre, :created_at, :updated_at
  if @post_image.post_image.attached?
    image = @post_image.encode_base64(@post_image.post_image)
  end
  json.post_image(image)
end

json.set! :user do
  json.extract! @user, :id, :user_name, :account_name
  json.user_post_image_count(@count)
end