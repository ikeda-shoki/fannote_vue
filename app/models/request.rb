class Request < ApplicationRecord
  belongs_to :requester
  belongs_to :requested
end
