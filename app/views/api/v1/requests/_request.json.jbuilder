json.extract! request, :id, :request_introduction, :file_format, :use, :amount, :request_status
if request.reference_image.attached?
  image = request.encode_base64(request.reference_image)
end
json.referance_image(image)
json.deadline( l request.deadline )
json.created_at( l request.created_at, format: :date )