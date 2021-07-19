# frozen_string_literal: true

require 'rails_helper'

describe '新規会員登録のテスト' do
  before do
    visit new_user_registration_path
  end
  it '有効な値を入力した場合会員登録できる' do
    fill_in 'user[name]',                  with: Faker::Name.name
    fill_in 'user[email]',                 with: Faker::Internet.free_email
    select  '2000',                        from: 'user_birth_date_1i'
    select  '1',                           from: 'user_birth_date_2i'
    select  '1',                           from: 'user_birth_date_3i'
    choose  'user_sex_女性'
    fill_in 'user[password]',              with: '123456'
    fill_in 'user[password_confirmation]', with: '123456'
    click_button '新規登録'
    expect(page).to have_content '登録が完了しました'
  end
end

describe 'ログインのテスト' do
  let(:user) { create(:user) }
  it '有効な値の場合ログインできる' do
    # login(user)
    # expect(page).to have_content 'ログインしました'
    post user_session_path, params: { session_form: { user: user } }
    expect(response).to redirect_to recipes_path
  end
end