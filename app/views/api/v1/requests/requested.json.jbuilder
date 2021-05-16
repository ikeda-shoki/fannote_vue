json.set! :requests do
  json.array! @requests do |request|
    json.partial! "api/v1/requests/request", request: request
    json.set! :requesting_user do
      json.partial! "api/v1/users/user", user: request.requester
    end
  end
end