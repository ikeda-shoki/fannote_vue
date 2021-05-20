class PostImage < ApplicationRecord
  has_one_attached :post_image
  attr_accessor :image

  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :hash_tags, through: :post_image_hashtag_relations, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :title, presence: { message: "タイトルを入力してください。" }
  validates :post_image_genre, presence: { message: "ジャンルを選択してください。" }
  validates :post_image, presence: { message: "画像を選択してください。" }

  enum post_image_genre: { イラスト: 0, 写真: 1, ロゴ: 2 }

  def parse_base64(image)
    if image.present? || rex_image(image) == ''
      content_type = create_extension(image)
      contents = image.sub %r/data:((image|application)\/.{3,}),/, ''
      decoded_data = Base64.decode64(contents)
      filename = Time.zone.now.to_s + '.' + content_type
      File.open("#{Rails.root}/tmp/#{filename}", 'wb') do |f|
        f.write(decoded_data)
      end
      attach_image(filename)
    end
  end

  def encode_base64(image_file)
    image = Base64.encode64(image_file.download)
    blob = ActiveStorage::Blob.find(image_file[:id])
    "data:#{blob[:content_type]};base64,#{image}"
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def get_post_image_comment
    post_image_comments.preload(:user).order('created_at DESC')
  end

  def self.my_follower_img(current_user)
    where(user_id: current_user.following_user.pluck(:id))
  end

  def self.search_keyword(keyword)
    where(['title LIKE ? OR image_introduction LIKE ?', "%#{keyword}%", "%#{keyword}%"])
  end

  def self.following_img(following_user)
    where(user_id: following_user.pluck(:id)).reverse_order
  end

  # controller用 scope
  scope :sort_new, -> (count) { order('id desc').limit(count) }

  private

  def create_extension(image)
    content_type = rex_image(image)
    content_type[%r/\b(?!.*\/).*/]
  end

  def rex_image(image)
    image[%r/(image\/[a-z]{3,4})|(application\/[a-z]{3,4})/]
  end

  def attach_image(filename)
    post_image.attach(io: File.open("#{Rails.root}/tmp/#{filename}"), filename: filename)
    FileUtils.rm("#{Rails.root}/tmp/#{filename}")
  end
end
