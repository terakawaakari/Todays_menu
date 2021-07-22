class Recipe < ApplicationRecord

  attachment :recipe_image

  enum genre:    [ :"和食", :"洋食", :"中華", :"その他" ],                                      _suffix: true
  enum category: [ :"主菜", :"主食", :"副菜", :"汁物",   :"デザート", :"その他" ],              _suffix: true
  enum taste:    [ :"醤油", :"みそ", :"塩",   :"トマト", :"クリーム", :"スパイス", :"その他" ], _suffix: true

  has_many :ingredients,  dependent: :destroy
  has_many :directions,   dependent: :destroy
  has_many :menu_recipes, dependent: :destroy
  has_many :menus,        through:   :menu_recipes
  has_many :recipe_tags,  dependent: :destroy
  has_many :tags,         through:   :recipe_tags
  has_many :bookmarks,    dependent: :destroy

  validates :is_open,  inclusion: [true, false]
  validates :genre,    presence: true
  validates :category, presence: true
  validates :taste,    presence: true
  validates :name,     presence: true

  accepts_nested_attributes_for :ingredients, :directions, allow_destroy: true

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags     = current_tags - sent_tags
    new_tags     = sent_tags    - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_recipe_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_recipe_tag
    end
  end

  def marked_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end

  def self.open_sort
    where(is_open: true).order(created_at: :DESC)
  end

end
