FactoryBot.define do
  factory :direction do
    trait :recipe do
      recipe_id { 1 }
      description { 'hogehoge' }
    end
    trait :private_recipe do
      recipe_id { 3 }
      description { 'hogehoge' }
    end
  end
end