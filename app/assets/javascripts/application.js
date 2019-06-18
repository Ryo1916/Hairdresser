//= require jquery
//= require popper
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require social-share-button
//= require_tree .

$(document).ready(function(){

  // initialize tooltips
  $('[data-toggle="tooltip"]').tooltip()

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
      if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '')
        && location.hostname == this.hostname) {
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
  });

  // validation for categories
  $('#create-categories').submit(function(){
    const VALID_CATEGORIES_REGEX = /^[a-zA-Z ]+$/;
    var categoryName = $('#category_name').val();

    if (categoryName == "") {
      $('#name-error').text("* Fill category name.");
      $("#name-error").show();
      return false;
    } else if (!VALID_CATEGORIES_REGEX.test(categoryName)){
      $('#name-error').text("* Valid only alphabet(case sensitive).");
      $('#name-error').show();
      return false;
    }
  });

  // display alert when user move other page and input text is not unsaved
  $(window)
    // initialize the form
    .on('turbolinks:load', function () {
      if (!window.formConfig) window.formConfig = {};
      window.formConfig.isDirty = false;
      window.formConfig.isSubmit = false;
      window.formConfig.confirmMessage = 'Are you sure? All text you wrote will be unsaved.';

      $(':input').change(function () {
        if (!window.formConfig.isDirty) window.formConfig.isDirty = true;
      });
      $('form').submit(function () {
        window.formConfig.isSubmit = true;
      });
    })
    // when move to other pages by Turbolinks
    .on("page:before-change turbolinks:before-visit", function () {
      if (window.formConfig.isDirty) {
        return confirm(window.formConfig.confirmMessage);
      }
    })
    // when reload the page or close the page/tab
    .bind("beforeunload", function (event) {
      if (!window.formConfig.isSubmit && window.formConfig.isDirty) {
        event.returnValue = window.formConfig.confirmMessage;
        return event.returnValue;
      }
    });
});

// display spinner until finishing loading the top movie.
$(window).on('pageshow', function() {
  $('#now-loading').hide();
  $('#now-loading').removeClass('d-flex');
  $('#movie').fadeIn();
});
