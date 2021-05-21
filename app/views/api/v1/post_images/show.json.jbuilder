json.set! :post_image do
  json.partial! "api/v1/post_images/post_image", post_image: @post_image
  json.set! :user do
    json.partial! "api/v1/users/user", user: @user
  end
  json.hash_tags(@hash_tags)
  json.part_image_introductions(@image_introduction)
end

json.set! :user do
  json.partial! "api/v1/users/user", user: @user
  json.follower(current_user.following?(@user))
  json.set! :post_images do
    json.array! @user.post_images.order(id: "DESC") do |post_image|
      json.partial! "api/v1/post_images/post_image", post_image: post_image
    end
  end
end

json.set! :post_comments do
  json.array! @post_comments do |post_comment|
    json.extract! post_comment, :id, :comment
    json.set! :user do
      json.partial! "api/v1/users/user", user: post_comment.user
    end
  end
end