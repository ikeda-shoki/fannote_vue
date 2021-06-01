# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Request, "モデルに関するテスト", type: :model do
  describe '実際に保存する' do
    it "有効な依頼が保存されるか" do
      expect(FactoryBot.build(:request)).to be_valid
    end
  end

  context 'Requestのバリデーションチェック' do
    it 'request_introductionが空白' do
      request = FactoryBot.build(:request)
      request.request_introduction = ""
      expect(request).to be_invalid
      expect(request.errors[:request_introduction]).to include("依頼内容は必ず入力してください")
    end
    it 'file_formatが空白' do
      request = FactoryBot.build(:request)
      request.file_format = ""
      expect(request).to be_invalid
      expect(request.errors[:file_format]).to include("ファイル形式は必ず選択してください")
    end
    it 'useが空白' do
      request = FactoryBot.build(:request)
      request.use = ""
      expect(request).to be_invalid
      expect(request.errors[:use]).to include("用途は必ず入力してください")
    end
    it 'deadlineが空白' do
      request = FactoryBot.build(:request)
      request.deadline = ""
      expect(request).to be_invalid
      expect(request.errors[:deadline]).to include("締め切りは必ず入力してください")
    end
    it 'deadlineが今日から３日後以内' do
      request = FactoryBot.build(:request)
      request.deadline = Faker::Date.between(from: Date.today, to: 2.days.after)
      expect(request).to be_invalid
      expect(request.errors[:deadline]).to include("締切日は、最短で本日から3日後で設定してください")
    end
    it 'deadlineが今日より前' do
      request = FactoryBot.build(:request)
      request.deadline = Faker::Date.backward
      expect(request).to be_invalid
      expect(request.errors[:deadline]).to include("締切日は、最短で本日から3日後で設定してください")
    end
    it 'amountが100枚以上' do
      request = FactoryBot.build(:request)
      request.amount = Faker::Number.between(from: 100)
      expect(request).to be_invalid
      expect(request.errors[:amount]).to include("数量は1以上の値を選択してください")
    end
    it 'amountが0枚以下' do
      request = FactoryBot.build(:request)
      request.amount = Faker::Number.between(to: 0)
      expect(request).to be_invalid
      expect(request.errors[:amount]).to include("数量は1以上の値を選択してください")
    end
  end

  describe "request_imagesに関するテスト" do
    let(:request) { FactoryBot.create(:request) }

    it 'requet_imagesが空の時のエラー' do
      request.valid?(:update_complete_image)
      expect(request.errors[:request_images]).to include("画像を選択してください")
    end
  end
end