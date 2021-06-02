# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostImage, "モデルに関するテスト", type: :model do
  let(:post_image) { FactoryBot.build(:post_image) }

  describe "PostImageについて" do
    before do
      post_image.post_image = fixture_file_upload('app/assets/images/illust.png')
    end

    describe '実際に保存する' do
      it "有効な投稿が保存されるか" do
        expect(post_image).to be_valid
      end
    end

    context 'PostImageのバリデーションチェック' do
      it 'titleが空白' do
        post_image.title = ""
        expect(post_image).to be_invalid
        expect(post_image.errors[:title]).to include("タイトルを入力してください。")
      end
      it 'ジャンルが未選択' do
        post_image.post_image_genre = ""
        expect(post_image).to be_invalid
        expect(post_image.errors[:post_image_genre]).to include("ジャンルを選択してください。")
      end
    end
  end

  # describe "PostImageのpost_imageについて" do
  #   it '画像が空' do
  #     expect(post_image).to be_invalid
  #     expect(post_image.errors[:post_image]).to include("画像を選択してください。")
  #   end
  # end

end