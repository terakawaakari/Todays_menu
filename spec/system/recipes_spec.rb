# frozen_string_literal: true

require 'rails_helper'

describe 'レシピの表示に関するテスト' do
  let!(:user)                 { create(:user,   :customer) }
  let!(:other_user)           { create(:user,   :customer) }
  let!(:recipe)               { create(:recipe, :valid) }
  let!(:other_recipe)         { create(:recipe, :other_recipe) }
  let!(:private_recipe)       { create(:recipe, :private_recipe) }
  let!(:other_private_recipe) { create(:recipe, :other_private_recipe) }
  let!(:bookmark)             { create(:bookmark) }

  context 'レシピタイムラインのテスト' do
    before do
      login(user)
      visit recipes_path
    end

    it '非公開のレシピは表示されない' do
      expect(page).not_to have_content private_recipe.name
    end
    it '公開レシピの画像と料理名が表示されている' do
      expect(page).to have_selector("img[src$='recipe_image.jpeg']")
      expect(page).to have_content recipe.name
    end
    it '公開レシピ詳細画面へのリンクがある' do
      expect(page).to have_link recipe.name, href: recipe_path(recipe)
    end
  end

  context 'マイレシピ一覧のテスト' do
    before do
      login(user)
      visit my_recipe_path
    end

    it '他ユーザーのレシピは表示されない' do
      expect(page).not_to have_content other_recipe.name
    end
    it '非公開のマイレシピが表示される' do
      expect(page).to have_content private_recipe.name
    end
    it 'マイレシピの画像と料理名が表示されている' do
      expect(page).to have_selector("img[src$='recipe_image.jpeg']")
      expect(page).to have_content recipe.name
    end
    it 'レシピ詳細画面へのリンクがある' do
      expect(page).to have_link recipe.name, href: recipe_path(recipe)
    end
  end

  context 'ブックマーク一覧のテスト' do
    before do
      login(user)
      visit user_bookmarks_path(user)
    end

    it '非公開のレシピは表示されない' do
      expect(page).not_to have_content other_recipe.name
    end
    it 'ブックマークしたレシピの画像と料理名が表示されている' do
      expect(page).to have_selector("img[src$='recipe_image.jpeg']")
      expect(page).to have_content bookmark.recipe.name
    end
    it 'レシピ詳細画面へのリンクがある' do
      expect(page).to have_link recipe.name, href: recipe_path(bookmark.recipe)
    end
  end

  context 'レシピ詳細画面のテスト' do
    before do
      login(user)
    end

    it 'レシピの画像と料理名が表示されている' do
      FactoryBot.create(:direction,  :recipe)
      FactoryBot.create(:ingredient, :recipe)
      visit recipe_path(recipe)
      expect(page).to have_selector("img[src$='recipe_image.jpeg']")
      expect(page).to have_content recipe.name
    end
    it '他ユーザーの非公開のレシピは表示されず、タイムラインに遷移する' do
      visit recipe_path(other_private_recipe)
      expect(current_path).to eq recipes_path
    end
    it '非公開のマイレシピは表示される' do
      FactoryBot.create(:direction,  :private_recipe)
      FactoryBot.create(:ingredient, :private_recipe)
      visit recipe_path(private_recipe)
      expect(page).to have_content private_recipe.name
    end
    it 'マイレシピの場合、編集・削除のリンクが表示される' do
      FactoryBot.create(:direction,  :recipe)
      FactoryBot.create(:ingredient, :recipe)
      visit recipe_path(recipe)
      expect(page).to have_link '編集', href: edit_recipe_path(recipe)
      expect(page).to have_link '削除', href: recipe_path(recipe)
    end
    it '他ユーザーの編集画面に遷移できず、マイレシピ一覧へ遷移する' do
      visit edit_recipe_path(other_recipe)
      expect(current_path).to eq recipes_path
    end
  end
end

describe 'レシピの保存・編集のテスト' do
  let!(:user) { create(:user, :customer) }
  let!(:recipe) { create(:recipe, :valid) }

  before do
    login(user)
  end

  it '正常に保存でき、レシピ詳細画面に遷移する' do
    visit new_recipe_path
    fill_in 'recipe[name]', with: 'ハンバーグ'
    select '和食',          from: 'recipe[genre]'
    select '主菜',          from: 'recipe[category]'
    select '醤油',          from: 'recipe[taste]'
    choose 'recipe_is_open_true'
    click_button 'レシピを保存'
    expect(page).to have_content '保存しました'
    expect(current_path).to eq recipe_path(2)
  end
  it '正常に更新でき、レシピ詳細画面に遷移する' do
    visit edit_recipe_path(recipe)
    fill_in 'recipe[name]', with: 'メンチカツ'
    click_button 'レシピを保存'
    expect(page).to have_content '変更しました'
    expect(current_path).to eq recipe_path(1)
  end
end
