json.set! :request do
  json.partial! "api/v1/requests/request", request: @request
end