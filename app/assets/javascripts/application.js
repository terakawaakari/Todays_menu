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
//= require_tree .
//= require cocoon
//= require jquery.raty.js


// レスポンシブ検索フォーム
$(document).on('turbolinks:load', function() {
  $('.search-icon').on('click', function(event) {
    $('#search-form').fadeToggle();
    event.preventDefault();
  });
});


// レスポンシブサイドバー
$(document).on('turbolinks:load', function() {
  $('.menu-trigger').on('click', function(event) {
    $(this).toggleClass('active');
    document.querySelector('section').classList.toggle('open-menu');
    // $('body').not('section').css('background-color', 'rgba(0,0,0,0.7)');
    event.preventDefault();
  });
});
