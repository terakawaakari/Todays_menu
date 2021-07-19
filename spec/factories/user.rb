FactoryBot.define do
  factory :user do
    name                  { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    sex                   { '男性' }
    birth_date            { '2000-01-01' }
    password              { 'password' }
    password_confirmation { 'password' }
    admin                 { false }
  end
end