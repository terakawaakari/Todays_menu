# frozen_string_literal: true

require 'rails_helper'

describe 'ログイン前のテスト' do
  it 'トップ画面にログイン・新規登録・ゲストログインへのリンクが表示される' do
    visit root_path
    expect(page).to have_link '新規登録', href: new_user_registration_path
    expect(page).to have_link 'ログイン', href: new_user_session_path
    expect(page).to have_link 'ゲストログイン', href: users_guest_sign_in_path
  end
  it 'レシピ一覧画面へ遷移できない' do
    visit recipes_path
    expect(current_path).to eq new_user_session_path
  end
  it 'メニュー一覧画面へ遷移できない' do
    visit menus_path
    expect(current_path).to eq new_user_session_path
  end
  it '買い物リスト画面へ遷移できない' do
    visit buy_items_path
    expect(current_path).to eq new_user_session_path
  end
  it 'ルーレット画面へ遷移できない' do
    visit roulette_path
    expect(current_path).to eq new_user_session_path
  end
end

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
  it '正しくゲストログインできる' do
    visit root_path
    all('li')[2].click_on 'ゲストログイン'
    expect(page).to have_content 'ログインしました'
  end
  it 'ログイン後の遷移先がレシピタイムラインになっている' do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
    expect(current_path).to eq recipes_path
  end
  it 'ログイン後はトップページにログイン・新規登録・ゲストログインのリンクが表示されない' do
    login(user)
    visit root_path
    expect(page).not_to have_content '新規登録'
    expect(page).not_to have_content 'ログイン'
    expect(page).not_to have_content 'ゲストログイン'
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
  let(:recipe) { create(:recipe, :valid) }

  before do
    login(admin)
  end

  it '会員一覧を閲覧することができる' do
    visit users_path
    expect(current_path).to eq users_path
  end
  it '会員一覧にパスワードが表示されていない' do
   visit users_path
   expect(page).not_to have_content other_user.password
  end
  it '会員の詳細ページへ遷移できる' do
    visit user_path(other_user)
    expect(current_path).to eq user_path(other_user)
  end
  it '会員情報編集画面へ遷移できる' do
    visit edit_user_path(other_user)
    expect(current_path).to eq edit_user_path(other_user)
  end
  it '会員の情報を編集できる' do
    visit edit_user_path(other_user)
    fill_in 'user[name]', with: 'hoge'
    click_button '変更'
    expect(page).to have_content '変更を保存しました'
  end
  it '会員を強制退会させることができ、ユーザ一覧画面へ遷移する', js: true do
    visit edit_user_path(other_user)
    page.accept_confirm do
      click_on '強制退会'
    end
    expect(page).to have_content '強制退会を実行しました'
    expect(current_path).to eq users_path
  end
  it 'レシピを投稿したユーザのIDを確認することができる' do
    visit recipe_path(recipe)
    expect(page).to have_content "ID #{other_user.id}"
  end
  it 'レシピ詳細ページに投稿したユーザの詳細画面へのリンクがある' do
    visit recipe_path(recipe)
    expect(page).to have_link href: user_path(other_user)
  end
end
