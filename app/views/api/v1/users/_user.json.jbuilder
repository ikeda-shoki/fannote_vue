json.extract! user, :id, :user_name, :account_name, :user_introduction, :is_reception, :complete_request_count
if user.profile_image.attached?
  image = user.encode_base64(user.profile_image)
end
json.profile_image(image)
json.user_post_image_count(user.post_images.count)
json.current_user_same_as(user.current_user_same_as?(current_user))
json.follower_count(user.following_user.count)
json.followed_count(user.followed_user.count)

