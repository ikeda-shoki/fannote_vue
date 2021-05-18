json.extract! request, :id, :request_introduction, :file_format, :use, :amount, :request_status, :deadline
if request.reference_image.attached?
  image = request.encode_base64(request.reference_image)
end
json.reference_image(image)
images = []
if request.request_images.attached?
  request.request_images.each do |request_image|
    images.push(request.encode_base64(request_image))
  end
end
json.request_images(images)
json.vue_deadline( l request.deadline )
json.created_at( l request.created_at, format: :date )
json.set! :requesting_user do
  json.partial! "api/v1/users/user", user: request.requester
end
json.set! :requested_user do
  json.partial! "api/v1/users/user", user: request.requested
end