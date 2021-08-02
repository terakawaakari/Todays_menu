# frozen_string_literal: true

require 'rails_helper'

describe '新規会員登録のテスト' do
  before do
    visit new_user_registration_path
    fill_in 'user[name]',                  with: Faker::Name.name
    fill_in 'user[email]',                 with: Faker::Internet.free_email
    select  '2000',                        from: 'user_birth_date_1i'
    select  '1',                           from: 'user_birth_date_2i'
    select  '1',                           from: 'user_birth_date_3i'
    choose  'user_sex_女性'
    fill_in 'user[password]',              with: '123456'
    fill_in 'user[password_confirmation]', with: '123456'
  end

  it '正しく会員登録できる' do
    click_button '新規登録'
    expect(page).to have_content '登録が完了しました'
  end
  it '会員登録後の遷移先がレシピタイムラインになっている' do
    click_button '新規登録'
    expect(current_path).to eq recipes_path
  end
end

describe 'ログインのテスト' do
  let(:user) { create(:user, :customer) }

  it '正しくログインできる' do
    login(user)
    expect(page).to have_content 'ログインしました'
  end
  it 'ログイン後の遷移先がレシピタイムラインになっている' do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
    expect(current_path).to eq recipes_path
  end
end

describe '会員のテスト' do
  let!(:user) { create(:user, :customer) }
  let!(:other_user) { create(:user, :customer) }

  before do
    login(user)
  end

  it '会員情報を変更できる' do
    visit edit_user_path(user)
    fill_in 'user[name]', with: 'hoge'
    click_button '変更'
    expect(page).to have_content '変更を保存しました'
  end
  context '退会のテスト' do
    before do
      visit user_path(user)
    end

    it '退会前にパスワード入力フォームが表示される' do
      find(".withdraw-link").click
      expect(page).to have_field 'user_current_password'
    end
    it '退会することができる' do
      find(".withdraw-link").click
      fill_in 'user_current_password', with: user.password
      click_on '退会する'
      expect(page).to have_content 'アカウントを削除しました'
    end
    it '退会後はトップページに遷移する' do
      find(".withdraw-link").click
      fill_in 'user_current_password', with: user.password
      click_on '退会する'
      expect(current_path).to eq root_path
    end
    it '退会後にログインすることができない' do
      find(".withdraw-link").click
      fill_in 'user_current_password', with: user.password
      click_on '退会する'
      login(user)
      expect(current_path).to eq new_user_session_path
    end
  end

  context 'アクセス制限のテスト' do
    it '会員は他ユーザーのマイページを閲覧できず、レシピタイムラインへ遷移する' do
      visit user_path(other_user)
      expect(current_path).to eq recipes_path
    end
    it '会員は他ユーザーの編集画面に遷移できず、レシピタイムラインへ遷移する' do
      visit edit_user_path(other_user)
      expect(current_path).to eq recipes_path
    end
    it '会員は会員一覧画面へ遷移できず、レシピタイムラインへ遷移する' do
      visit users_path
      expect(current_path).to eq recipes_path
    end
  end
end

describe '管理者のテスト' do
  let(:admin) { create(:user, :admin) }
  let!(:other_user) { create(:user, :customer) }

  before do
    login(admin)
  end

  it '管理者は会員一覧を閲覧することができる' do
    visit users_path
    expect(current_path).to eq users_path
  end
  it '管理者は会員の詳細ページへ遷移できる' do
    visit user_path(other_user)
    expect(current_path).to eq user_path(other_user)
  end
  it '管理者は会員の情報編集画面へ遷移できる' do
    visit edit_user_path(other_user)
    expect(current_path).to eq edit_user_path(other_user)
  end
  it '管理者は会員の情報を編集できる' do
    visit edit_user_path(other_user)
    fill_in 'user[name]', with: 'hoge'
    click_button '変更'
    expect(page).to have_content '変更を保存しました'
  end
end
