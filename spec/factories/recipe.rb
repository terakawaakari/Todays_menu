FactoryBot.define do
  factory :recipe do
    user_id         { Faker::Number.non_zero_digit }
    name            { Faker::Lorem.characters(number:10) }
    recipe_image_id { Faker::Alphanumeric.alphanumeric(number: 10) }
    genre           { "和食" }
    category        { "主菜" }
    taste           { "醤油" }
    is_open         { true }
  end
end