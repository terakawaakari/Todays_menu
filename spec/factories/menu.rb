FactoryBot.define do
  factory :menu do
    trait :valid do
      menu_image    { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.png'), 'image/png') }
      user_id       { 1 }
      # user
      list          { "・テスト" }
      category      { "朝食" }
      date          { "2021-01-01" }
    end

    trait :no_image do
      user_id       { 1 }
      # user
      list          { "・テスト" }
      category      { "朝食" }
      date          { "2021-01-01" }
    end
    
    trait :no_date do
      menu_image    { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.png'), 'image/png') }
      user_id       { 1 }
      # user
      list          { "・テスト" }
      category      { "朝食" }
    end
  end
end