# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, "モデルに関するテスト", type: :model do
  describe '実際に保存する' do
    it "有効なユーザーが保存されるか" do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end

  context 'Userバリデーションチェック(エラーメッセージの確認)' do
    it 'user_nameが空白時に保存されない' do
      user = FactoryBot.build(:user)
      user.user_name = ""
      expect(user).to be_invalid
      expect(user.errors[:user_name]).to include('名前を入力してください。')
    end
    it 'emailが空白時に保存されない' do
      user = FactoryBot.build(:user)
      user.email = ""
      expect(user).to be_invalid
      expect(user.errors[:email]).to include('を入力してください')
    end
    it 'account_nameが重複' do
      unique_user = FactoryBot.build(:user)
      unique_user.save
      unique_user2 = FactoryBot.build(:user)
      unique_user2.account_name = unique_user.account_name
      expect(unique_user2).to be_invalid
      expect(unique_user2.errors[:account_name]).to include('入力されたアカウントネームは使用されています。')
    end
    it 'emailが重複' do
      unique_user = FactoryBot.build(:user)
      unique_user.save
      unique_user2 = FactoryBot.build(:user)
      unique_user2.email = unique_user.email
      expect(unique_user2).to be_invalid
      expect(unique_user2.errors[:email]).to include('はすでに存在します')
    end
  end
end