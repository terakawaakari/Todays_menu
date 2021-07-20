FactoryBot.define do
  factory :recipe do
    trait :valid do
      user_id         { 1 }
      name            { Faker::Lorem.characters(number:10) }
      recipe_image_id { Faker::Alphanumeric.alphanumeric(number: 10) }
      genre           { "和食" }
      category        { "主菜" }
      taste           { "醤油" }
      is_open         { true }
    end

    trait :no_name do
      user_id         { 1 }
      recipe_image_id { Faker::Alphanumeric.alphanumeric(number: 10) }
      genre           { "和食" }
      category        { "主菜" }
      taste           { "醤油" }
      is_open         { true }
    end

    trait :no_open_status do
      user_id         { 1 }
      name            { Faker::Lorem.characters(number:10) }
      recipe_image_id { Faker::Alphanumeric.alphanumeric(number: 10) }
      genre           { "和食" }
      category        { "主菜" }
      taste           { "醤油" }
    end
  end
end