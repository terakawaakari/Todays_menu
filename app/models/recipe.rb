class Recipe < ApplicationRecord

  attachment :recipe_image

  enum genre:    [ :"和食", :"洋食", :"中華", :"その他" ],                       _suffix: true
  enum category: [ :"主菜", :"主食", :"副菜", :"汁物", :"デザート", :"その他" ], _suffix: true
  enum taste:    [ :"醤油", :"みそ", :"塩",   :"その他" ],                       _suffix: true

end