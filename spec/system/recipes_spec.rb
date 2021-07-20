# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト' do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe) }
  before do
    login(user)
    visit recipes_path
  end
  describe 'レシピタイムラインのテスト' do
    it '非公開のレシピが表示されていないか' do
      private_recipe = Recipe.create(name: Faker::Lorem.characters(number:10), is_open: false)
      expect(private_recipe).not_to have_content private_recipe.name
    end
    context '一覧の表示とリンクの確認' do
      # before do
      #   visit recipes_path
      # end
      it 'レシピの画像と料理名が表示されているか' do
        # recipe = FactoryBot.build(:recipe)
        # recipe = Recipe.create(name: Faker::Lorem.characters(number:10), recipe_image_id: Faker::Alphanumeric.alphanumeric(number: 10), is_open: true)
        expect(page).to have_content recipe.recipe_image_id
        expect(page).to have_content recipe.name
      end
    end
  end
end