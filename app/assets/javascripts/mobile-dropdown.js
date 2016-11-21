$(document).ready(function() {
  var showDropdown = false;

  $('#mobile-nav').click(function() {
    if (!showDropdown) {
      $('#mobile-navbar').slideDown();
      showDropdown = true;
    } else {
      $('#mobile-navbar').slideUp();
      showDropdown = false;
    }
  });

  $('nav li').click(function() {
    showDropdown = false;
    window.location.href = $(this).find('a')[0].href;
  });
});
