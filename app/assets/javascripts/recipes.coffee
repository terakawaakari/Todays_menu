# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# レシピ保存フォームの作り方を並び替え可能に
$ ->
  el = document.getElementById("directions")
  if el != null
    sortable = Sortable.create(el, delay: 200)

# レシピ保存フォームの材料を並び替え可能に
$ ->
  el = document.getElementById("ingredients")
  if el != null
    sortable = Sortable.create(el, delay: 200)
