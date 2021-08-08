FactoryBot.define do
  factory :ingredient do
    trait :recipe do
      recipe_id { 1 }
      name { 'チーズ' }
      quantity { '50g' }
    end
    trait :private_recipe do
      recipe_id { 3 }
      name { 'hogehoge' }
      quantity { 'hoge' }
    end
  end
end