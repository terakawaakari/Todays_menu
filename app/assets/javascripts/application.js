// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery3
//= require popper
//= require bootstrap-sprockets

//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require cocoon
//= require jquery.raty.js
//= require_tree .

/*global $ */

// レスポンシブ検索フォーム
$(document).on('turbolinks:load', function(){
  $('.search-icon').on('click', function(e){
    $('#search-form').fadeToggle();
    e.preventDefault();
  });
});


// レスポンシブサイドバー
$(document).on('turbolinks:load', function(){
  $('.menu-trigger').on('click', function(e) {
    $(this).toggleClass('active');
    document.querySelector('section').classList.toggle('open-menu');
    // $('body').not('section').css('background-color', 'rgba(0,0,0,0.7)');
    e.preventDefault();
  });
});

// トップへ戻るボタン
$(document).on('turbolinks:load', function(){
  var topBtn = $('#page-top');
  $(window).scroll(function () {
    if ($(this).scrollTop() > 100) {
      topBtn.fadeIn();
    }else{
      topBtn.fadeOut();
    }
  });
  $('#page-top a').on('click', function(e){
    $('body, html').animate({
      scrollTop: 0
    }, 800);
    e.preventDefault();
  });
});

// インクリメンタルサーチ
function add_form(){
  $('.js-text_field').off('change')
  $('.js-text_field').on('change', function () {
    var name = $.trim($(this).val());
    if (!name){
      return
    }
    var text_field = $(this)

    $.ajax({
      type: 'GET',
      url: '/menu_recipe_search',
      data: { name: name },
      dataType: 'json'
    })
    .done(function (data) {
      $(data).each(function (i, recipe) {
        var js_recipes = text_field.parent().parent().find('.js-recipes')
        js_recipes.empty()
        js_recipes.append('<a class="recipe d-inline-block">${recipe.name}</a>');
        $('.recipe').on('click', function() {
          $(this).parent().parent().find('select').val(recipe.id)
        });
      });
    });
  });
}

// レシピの表示切り替え
// window.onload = function() {
  $(document).on('turbolinks:load', function(){
      if (!document.getElementById("recipe-table")) return
      document.getElementById("recipe-table").style.display = "none";
      $(document).on("click",'.display-btn',function(){
        const recipe_table = document.getElementById("recipe-table");
      	const recipe_box   = document.getElementById("recipe-box");
      	const display_icon = document.getElementById("display-icon");
      	if(recipe_table.style.display == "block"){
      		recipe_table.style.display = "none";
      		recipe_box.style.display = "block";
      		display_icon.classList.add('fa-list');
      	  display_icon.classList.remove('fa-th-large');
      	}else{
      		recipe_table.style.display = "block";
          recipe_box.style.cssText += 'display: none !important;';
          display_icon.classList.add('fa-th-large');
      	  display_icon.classList.remove('fa-list');
      	}
      });
  });
// }

// ブックマークレシピの表示切り替え
// window.onload = function() {
  $(document).on('turbolinks:load', function(){
    if (!document.getElementById("bookmark-table")) return
    document.getElementById("bookmark-table").style.display = "none";
    $(document).on("click",'.display-btn',function(){
      const recipe_table = document.getElementById("bookmark-table");
    	const recipe_box   = document.getElementById("bookmark-box");
    	const display_icon = document.getElementById("display-icon");
    	if(recipe_table.style.display == "block"){
    		recipe_table.style.display = "none";
    		recipe_box.style.display = "block";
    		display_icon.classList.add('fa-list');
    	  display_icon.classList.remove('fa-th-large');
    	}else{
    		recipe_table.style.display = "block";
        recipe_box.style.cssText += 'display: none !important;';
        display_icon.classList.add('fa-th-large');
    	  display_icon.classList.remove('fa-list');
    	}
    });
  });
// }

// ルーレット
$(document).on('turbolinks:load', function(){
  var rotate = $("#circle");
  var roulette;
  var count = 0;

  $('#start').on('click', function start() {
    const button = document.getElementById("start");
    button.disabled = true
    roulette = setInterval(function(){
      count++;
      if(count > 360){
        count = 0;
      }else{
        rotate.css({ transform: "rotate("+ count*100+"deg)" });
      }
    }, 100);
  });

  $('#stop').on('click',function stop() {
    const button = document.getElementById("start");
    const stop_button = document.getElementById("stop");
    button.disabled = false
    if(roulette) {
      clearInterval(roulette);
      stop_button.blur();
    }
  });
});

// レシピ詳細表示の切り替え
// window.onload = function(){
  $(document).on('turbolinks:load', function(){
    if (!document.getElementById("details")) return
    document.getElementById("details").style.display ="none";
    $('#detail-btn').on('click', function(){
    	const details = document.getElementById("details");
    	const detail_btn = document.getElementById("detail-btn");
    	const detail_icon = document.getElementById("detail-icon");
    	if(details.style.display == "block"){
    		details.style.display = "none";
    	  detail_icon.classList.add('fa-caret-down');
    	  detail_icon.classList.remove('fa-caret-up');
    	}else{
    		details.style.display = "block";
    		detail_icon.classList.add('fa-caret-up');
    		detail_icon.classList.remove('fa-caret-down');
    	}
    });
  });
// }

// メニュー画像のプレビュー表示
$(document).on('turbolinks:load', function(){
  if (!document.getElementById("menu_menu_image")) return
  $('#menu_menu_image').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#menu-img-container').addClass('img my-3');
      $('#original-menu-img-container').removeClass('img');
      $("#menu-preview").attr('src', e.target.result);
      $('#original-menu-img').css('display','none');
    }
    reader.readAsDataURL(e.target.files[0]);
  });
});

// レシピ画像のプレビュー表示
$(document).on('turbolinks:load', function(){
  if (!document.getElementById("recipe_recipe_image")) return
  $('#recipe_recipe_image').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#img-container').addClass('img my-3');
      $('#original-img-container').removeClass('img');
      $("#recipe-preview").attr('src', e.target.result);
      $('#original-img').css('display','none');
    }
    reader.readAsDataURL(e.target.files[0]);
  });
});