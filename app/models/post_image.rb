class PostImage < ApplicationRecord
  has_one_attached :post_image
  attr_accessor :image

  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_image_hashtag_relations, dependent: :destroy
  has_many :hash_tags, through: :post_image_hashtag_relations, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :title, presence: { message: "タイトルを入力してください。" }
  validates :post_image_genre, presence: { message: "ジャンルを選択してください。" }
  # validates :post_image, presence: { message: "画像を選択してください。" }

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

  after_create do
    post_image = PostImage.find_by(id: id)
    post_image_hashtags = image_introduction.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    post_image.hash_tags = []
    post_image_hashtags.uniq.map do |hashtag|
      tag = HashTag.find_or_create_by(hashname: hashtag.downcase.delete('#＃'))
      post_image.hash_tags << tag
    end
  end

  before_update do
    post_image = PostImage.find_by(id: id)
    post_image.hash_tags.clear
    post_image_hashtags = image_introduction.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    post_image_hashtags.uniq.map do |hashtag|
      tag = HashTag.find_or_create_by(hashname: hashtag.downcase.delete('#＃'))
      post_image.hash_tags << tag
    end
  end

  def get_post_image_comment
    post_image_comments.preload(:user).order('created_at DESC')
  end

  def self.my_follower_img(current_user)
    where(user_id: current_user.following_user.pluck(:id))
  end

  def self.following_img(following_user)
    where(user_id: following_user.pluck(:id)).reverse_order
  end

  def create_notification_favorite(current_user)
    favorited = Notification.is_favite_notification(current_user.id, user_id, id)
    if favorited.blank?
      notification = current_user.active_notifications.new(
        post_image_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      unless notification.visitor_id === notification.visited_id
        notification.save
      end
    end
  end

  def create_notification_post_image_comment(current_user)
    notification = current_user.active_notifications.new(
      post_image_id: id,
      visited_id: user_id,
      action: 'post_image_comment'
    )
    unless notification.visitor_id === notification.visited_id
      notification.save
    end
  end

  # controller用 scope
  scope :sort_new, -> (count) { order('post_images.id desc').limit(count) }

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
