# frozen_string_literal: true

require 'rails_helper'

describe '買い物リストのテスト' do
  let!(:user) { create(:user, :customer) }
  let!(:item) { create(:buy_item) }

  before do
    login(user)
    visit buy_items_path
  end

  context '表示のテスト' do
    it '追加したアイテム名が表示される' do
      expect(page).to have_content item.name
    end
    it 'チェックボタンが表示される' do
      expect(page).to have_button ''
    end
    it '全削除ボタンが表示される' do
      expect(page).to have_link '全削除', href: all_destroy_path
    end
    it '購入済み削除ボタンが表示される' do
      expect(page).to have_link '購入済削除', href: bought_destroy_path
    end
  end
end