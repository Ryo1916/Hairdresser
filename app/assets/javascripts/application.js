//= require jquery
//= require popper
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require social-share-button
//= require_tree .

$(document).ready(function(){

  // add .navbar-background-top first
  $(".navbar").addClass("navbar-background-top");

  // change background-color of navbar
  $(function () {
    $(window).scroll(function () {
      if ($(this).scrollTop() > $('#movie').height()) {
        $('.navbar').removeClass("navbar-background-top");
        $('.navbar').addClass("navbar-background");
      } else {
        $('.navbar').removeClass("navbar-background");
        $('.navbar').addClass("navbar-background-top");
      }
    });
  });

  // move to the clicked section
  $(function () {
    // Select all links with hashes
    $('a[href*="#"]')
      // Remove links that don't actually link to anything
      .not('[href="#"]')
      .not('[href="#0"]')
      .click(function(event) {
      // On-page links
      if (
        location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '')
        &&
        location.hostname == this.hostname
      ) {
        // Figure out element to scroll to
        var target = $(this.hash);
        target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
        // Does a scroll target exist?
        if (target.length) {
          // Only prevent default if animation is actually gonna happen
          event.preventDefault();
          $('html, body').animate({
            scrollTop: target.offset().top
          }, 1000, function() {
            // Callback after animation
            // Must change focus!
            var $target = $(target);
            $target.focus();
            if ($target.is(":focus")) { // Checking if the target was focused
              return false;
            } else {
              $target.attr('tabindex','-1'); // Adding tabindex for elements not focusable
              $target.focus(); // Set focus again
            };
          });
        }
      }
    });
  })
});
