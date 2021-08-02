FactoryBot.define do
  factory :recipe do
    trait :valid do
      user_id         { 1 }
      name            { 'グラタン' }
      recipe_image    { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.png')) }
      genre           { "和食" }
      category        { "主菜" }
      taste           { "醤油" }
      is_open         { true }
    end

    trait :no_name do
      user_id         { 1 }
      recipe_image    { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.png')) }
      genre           { "和食" }
      category        { "主菜" }
      taste           { "醤油" }
      is_open         { true }
    end

    trait :private_recipe do
      user_id         { 1 }
      name            { 'プリン' }
      genre           { "和食" }
      category        { "主菜" }
      taste           { "醤油" }
      is_open         { false }
    end

    trait :other_private_recipe do
      user_id         { 2 }
      name            { 'お好み焼き' }
      genre           { "和食" }
      category        { "主菜" }
      taste           { "醤油" }
      is_open         { false }
    end

    trait :other_recipe do
      user_id         { 2 }
      name            { 'たこ焼き' }
      genre           { "和食" }
      category        { "主菜" }
      taste           { "醤油" }
      is_open         { true }
    end
  end
end