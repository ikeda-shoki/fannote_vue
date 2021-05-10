json.extract! post_image, :id, :title, :image_introduction, :post_image_genre
if post_image.post_image.attached?
  image = post_image.encode_base64(post_image.post_image)
end
json.post_image(image)
json.created_at( l post_image.created_at, format: :long )
json.updated_at( l post_image.updated_at, format: :long )
json.check_favorite(post_image.favorited_by?(current_user))
json.favorite_count(post_image.favorites.count)