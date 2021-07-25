# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "管理者",
            email: "admin@example.com",
            birth_date: "2021-07-01",
            sex: "女性",
            password:  "aaaaaa",
            password_confirmation: "aaaaaa",
            admin: true)
            
Roulette.create!(dish: "ハンバーグ")
Roulette.create!(dish: "餃子")
Roulette.create!(dish: "オムライス")
Roulette.create!(dish: "パスタ")
Roulette.create!(dish: "ドリア")
Roulette.create!(dish: "チャーハン")
Roulette.create!(dish: "ピザ")
Roulette.create!(dish: "唐揚げ")
Roulette.create!(dish: "焼肉")
Roulette.create!(dish: "焼き鳥")
Roulette.create!(dish: "牛丼")
Roulette.create!(dish: "カレー")
Roulette.create!(dish: "お寿司")
Roulette.create!(dish: "生姜焼き")
Roulette.create!(dish: "ハンバーガー")
Roulette.create!(dish: "お好み焼き")
Roulette.create!(dish: "たこ焼き")
Roulette.create!(dish: "グラタン")
Roulette.create!(dish: "シチュー")
Roulette.create!(dish: "コロッケ")
Roulette.create!(dish: "ラーメン")
Roulette.create!(dish: "すき焼き")
Roulette.create!(dish: "冷やし中華")
Roulette.create!(dish: "天ぷら")
Roulette.create!(dish: "鍋")
Roulette.create!(dish: "エビフライ")
Roulette.create!(dish: "うどん")
Roulette.create!(dish: "そば")
Roulette.create!(dish: "サンドイッチ")
Roulette.create!(dish: "エビチリ")
Roulette.create!(dish: "麻婆豆腐")
Roulette.create!(dish: "天津飯")
Roulette.create!(dish: "酢豚")
Roulette.create!(dish: "トンカツ")
Roulette.create!(dish: "カツ丼")
Roulette.create!(dish: "カップラーメン")
Roulette.create!(dish: "あんかけ焼きそば")