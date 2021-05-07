json.set! :user do
  json.extract! @user, :id, :user_name, :account_name, :user_introduction, :is_reception, :complete_request_count
  if @user.profile_image.attached?
    image = @user.encode_base64(@user.profile_image)
  end
  json.profile_image(image)
  json.user_post_image_count(@count)
  json.current_user_sign_in(@current_user_sign_in)
end

json.set! :post_images do
  json.array! @user.post_images do |post_image|
    json.extract! post_image, :id, :title, :image_introduction, :post_image_genre, :created_at, :updated_at
    if post_image.post_image.attached?
      image = post_image.encode_base64(post_image.post_image)
    end
    json.post_image(image)
  end
end