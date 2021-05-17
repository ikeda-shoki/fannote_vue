json.set! :requests do
  json.array! @requests do |request|
    json.partial! "api/v1/requests/request", request: request
  end
end