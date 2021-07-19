FactoryBot.define do
  factory :menu do
    menu_image_id { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.png'), 'image/png') }
    # menu_image_id { ("test.png", "image/png", true) }
    user_id       { 1 }
    # user
    list          { "・テスト" }
    category      { "朝食" }
    date          { "2021-01-01" }
  end
end