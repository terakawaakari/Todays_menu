# frozen_string_literal: true

require 'rails_helper'

describe 'recipeモデルのテスト' do
  it '有効な投稿内容の場合は保存されるか' do
    expect(FactoryBot.build(:recipe, :valid)).to be_valid
  end
  context 'バリデーションのテスト' do
    it 'nameが空白の場合は保存されないか' do
      expect(FactoryBot.build(:recipe, :no_name)).to be_invalid
    end
    it 'is_openが空白の場合は保存されないか' do
      expect(FactoryBot.build(:recipe, :no_open_status)).to be_invalid
    end
  end
end