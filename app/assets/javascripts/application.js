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
//= require jquery
//= require popper
//= require jquery_ujs
//= require bootstrap
//= require tinymce-jquery
//= require turbolinks
//= require_tree .

$(document).ready(function(){

  // hide .navbar first
  $(".navbar").addClass("navbar-background-top");

  // fade in .navbar
  $(function () {
    $(window).scroll(function () {
      // set distance user needs to scroll before we start fadeIn
      if ($(this).scrollTop() > 150) {
        $('.navbar').removeClass("navbar-background-top");
        $('.navbar').addClass("navbar-background");
      } else {
        $('.navbar').removeClass("navbar-background");
        $('.navbar').addClass("navbar-background-top");
      }
    });
  });

});
