FactoryBot.define do
  factory :buy_item do
    user_id   { 1 }
    name      { "ใใกใ" }
    is_bought { false }
  end
end