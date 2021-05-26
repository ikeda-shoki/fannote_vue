class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post_image

  validates :comment, presence: { message: "コメントを入力してください。"}
end
