module ApplicationHelper

  require "uri"

  def text_url_to_link(text)
    URI.extract(text, ["http", "https"]).uniq.each do |url|
      sub_text = ""
      sub_text << "<a href=" << url << " target=\"_blank\">" << url << "</a>"
      text.gsub!(url, sub_text)
    end
    return text
  end

  # レシピのタグを重複を省いて取得
  def unique_tags(recipes)
    RecipeTag.joins(:tag).where(recipe_id: recipes.pluck(:id)).select('tags.tag_name').distinct
  end
end
