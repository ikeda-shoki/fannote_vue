# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostComment, "モデルに関するテスト", type: :model do
  describe '実際に保存する' do
    it "有効なコメントが保存されるか" do
      expect(FactoryBot.build(:post_comment)).to be_valid
    end
  end

  context 'PostImageCommentのバリデーションチェック' do
    it 'commentが空白' do
      post_image = FactoryBot.build(:post_comment)
      post_image.comment = ""
      expect(post_image).to be_invalid
      expect(post_image.errors[:comment]).to include("コメントを入力してください。")
    end
  end
end
