# frozen_string_literal: true

require 'rails_helper'

describe 'menuモデルのテスト' do
  it '有効な投稿の場合は保存されるか' do
    expect(FactoryBot.build(:menu, :valid)).to be_valid
  end
  context 'バリデーションのテスト' do
    it '画像がない場合は投稿できない' do
      expect(FactoryBot.build(:menu, :no_image)).to be_invalid
    end
    it '日付が入力されていない場合は投稿できない' do
      expect(FactoryBot.build(:menu, :no_date)).to be_invalid
    end
  end
end