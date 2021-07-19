require 'rails_helper'

describe 'ログインのテスト' do
  let(:user) { create(:user) }
  it '有効な値の場合ログインできる' do
    login(user)
    expect(page).to have_content 'ログインしました'
  end
end