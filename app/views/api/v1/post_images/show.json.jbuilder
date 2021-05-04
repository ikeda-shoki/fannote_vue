json.set! :post_image do
  json.extract! @post_image, :id, :title, :image_introduction, :post_image_genre
  if @post_image.post_image.attached?
    image = @post_image.encode_base64(@post_image.post_image)
  end
  json.created_at( l @post_image.created_at, format: :long )
  json.updated_at( l @post_image.updated_at, format: :long )
  json.post_image(image)
  json.checkFavorite(@isFavorite)
  json.favoriteCount(@favorite_count)
end

json.set! :user do
  json.extract! @user, :id, :user_name, :account_name
  json.user_post_image_count(@count)
end

json.set! :post_comments do
  json.array! @post_comments do |post_comment|
    json.extract! post_comment, :id, :comment
    json.user(post_comment.user)
  end
end