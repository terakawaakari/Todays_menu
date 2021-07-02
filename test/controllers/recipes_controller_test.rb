require 'test_helper'

class RecipesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get recipes_index_url
    assert_response :success
  end

  test "should get my_recipe" do
    get recipes_my_recipe_url
    assert_response :success
  end

  test "should get show" do
    get recipes_show_url
    assert_response :success
  end

  test "should get new" do
    get recipes_new_url
    assert_response :success
  end

  test "should get edit" do
    get recipes_edit_url
    assert_response :success
  end

  test "should get recommend" do
    get recipes_recommend_url
    assert_response :success
  end

end
