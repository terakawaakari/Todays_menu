# frozen_string_literal: true

require 'rails_helper'

describe 'recipeモデルのテスト' do
  it '有効な投稿内容の場合は保存されるか' do
    expect(FactoryBot.build(:recipe)).to be_valid
  end

  context '空白のバリデーションチェック' do
    it 'nameが空白の場合は保存されないか' do
      recipe = Recipe.create(name: '', is_open: true)
      expect(recipe).to be_invalid
    end
    it 'is_openが空白の場合は保存されないか' do
      recipe = Recipe.create(name: Faker::Lorem.characters(number:10), is_open: '')
      expect(recipe).to be_invalid
    end
  end
end