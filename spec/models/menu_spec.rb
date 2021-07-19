# frozen_string_literal: true

require 'rails_helper'

describe 'menuモデルのテスト' do
  it '有効な投稿の場合は保存されるか' do
    expect(FactoryBot.build(:menu)).to be_valid
  end
end