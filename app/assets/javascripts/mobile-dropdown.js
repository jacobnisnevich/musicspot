$(document).ready(function() {
  var showDropdown = false;

  $(document).on('click', '#mobile-nav', function() {
    if (!showDropdown) {
      $('#mobile-navbar').slideDown();
      showDropdown = true;
    } else {
      $('#mobile-navbar').slideUp();
      showDropdown = false;
    }
  });

  $(document).on('click', '#mobile-navbar li', function() {
    showDropdown = false;
    window.location.href = $(this).find('a')[0].href;
  });
});
