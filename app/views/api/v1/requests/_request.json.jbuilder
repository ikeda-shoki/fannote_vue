json.extract! request, :id, :request_introduction, :file_format, :use, :amount, :request_status, :deadline
if request.reference_image.attached?
  image = request.encode_base64(request.reference_image)
end
json.reference_image(image)
json.vue_deadline( l request.deadline )
json.created_at( l request.created_at, format: :date )