class PostImage < ApplicationRecord
  has_one_attached :post_image

  belongs_to :user
end
