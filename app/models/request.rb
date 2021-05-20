class Request < ApplicationRecord
  has_one_attached :reference_image
  has_many_attached :request_images
  attr_accessor :image
  
  belongs_to :requester, class_name: "User"
  belongs_to :requested, class_name: "User"
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy

  enum file_format: { jpeg: 1, png: 2 }
  enum request_status: { 未受付: 0, 受付不可: 1, 製作中: 2, 製作完了: 3 }

  validates :request_introduction, presence: { message: "依頼内容は必ず入力してください"}
  validates :file_format, presence: { message: "ファイル形式は必ず選択してください"}
  validates :use, presence: { message: "用途は必ず入力してください"}
  validates :deadline, presence: { message: "締め切りは必ず入力してください"}
  validates :amount, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 99 }, presence: true
  validates :request_status, presence: true
  validates :request_images, presence: { message: "画像を選択してください"}, on: :update_complete_image
  validate :request_images_length, on: :update_complete_image
  validate :deadline_limit, on: [:create, :update]

  def deadline_limit
    if deadline.present?
      if deadline < Time.now || deadline < Time.current.since(2.days)
        errors.add(:deadline, '締切日は、最短で本日から3日後で設定してください')
      end
    end
  end

  def request_images_length
    if request_images.size > amount
      errors.add(:request_images, "選択された画像が指定枚数よりも多いです")
    end
  end

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

  def parse_base64s(images)
    if images.present?
      images.each do |image|
        content_type = create_extension(image)
        contents = image.sub %r/data:((image|application)\/.{3,}),/, ''
        decoded_data = Base64.decode64(contents)
        filename = Time.zone.now.to_s + '.' + content_type
        File.open("#{Rails.root}/tmp/#{filename}", 'wb') do |f|
          f.write(decoded_data)
        end
        attach_request_images(filename)
      end
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

  def self.following_img(following_user)
    where(user_id: following_user.pluck(:id)).reverse_order
  end

  private

  def create_extension(image)
    content_type = rex_image(image)
    content_type[%r/\b(?!.*\/).*/]
  end

  def rex_image(image)
    image[%r/(image\/[a-z]{3,4})|(application\/[a-z]{3,4})/]
  end

  def attach_image(filename)
    reference_image.attach(io: File.open("#{Rails.root}/tmp/#{filename}"), filename: filename)
    FileUtils.rm("#{Rails.root}/tmp/#{filename}")
  end

  def attach_request_images(filename)
    request_images.attach(io: File.open("#{Rails.root}/tmp/#{filename}"), filename: filename)
    FileUtils.rm("#{Rails.root}/tmp/#{filename}")
  end
end
