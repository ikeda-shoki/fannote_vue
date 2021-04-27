# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, "モデルに関するテスト", type: :model do
  describe '実際に保存する' do
    it "有効なユーザーが保存されるか" do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end
end