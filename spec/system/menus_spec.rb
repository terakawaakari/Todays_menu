# frozen_string_literal: true

require 'rails_helper'

describe 'メニューの表示に関するテスト' do
  let!(:user)       { create(:user, :customer) }
  let!(:other_user) { create(:user, :customer) }

  before do
    login(user)
  end

  context 'マイメニュー一覧のテスト' do
    let!(:menu)       { create(:menu, :valid) }
    let!(:other_menu) { create(:menu, :other_menu) }

    before do
      visit menus_path
    end

    it '他人のメニューは表示されない' do
      expect(page).not_to have_content other_menu.list
    end
    it '編集と削除のリンクが表示される' do
      expect(page).to have_link href: edit_menu_path(menu)
      expect(page).to have_link href: menu_path(menu)
    end
  end

  context 'カレンダーのテスト' do
    it '他人のメニューは表示されない' do
      create(:menu, :other_menu)
      visit calendar_path
      expect(page).not_to have_selector("img[src$='menu_image']")
    end
    it '自分のメニューが表示される' do
      create(:menu, :valid)
      visit calendar_path
      expect(page).to have_selector("img[src$='menu_image']")
    end
  end
end

describe 'メニューの保存・編集のテスト' do
  let!(:user) { create(:user, :customer) }
  let!(:other_user) { create(:user,   :customer) }
  let!(:menu) { create(:menu, :valid) }
  let!(:other_menu) { create(:menu, :other_menu) }

  before do
    login(user)
  end

  it '保存のテスト' do
    visit new_menu_path
    attach_file 'menu_menu_image', "#{Rails.root}/spec/fixtures/test.png"
    fill_in 'menu[date]', with: '002020-10-06'
    click_button 'メニューを保存'
    expect(page).to have_content '保存しました'
  end
  it '他ユーザーの編集画面に遷移できず、マイメニュー一覧へ遷移する' do
    visit edit_menu_path(other_menu)
    expect(current_path).to eq menus_path
  end
  it '編集のテスト' do
    visit edit_menu_path(menu)
    fill_in 'menu[date]', with: '002020-12-12'
    click_button 'メニューを保存'
    expect(page).to have_content '変更しました'
  end
end
