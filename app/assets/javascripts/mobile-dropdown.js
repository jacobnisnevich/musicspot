$(document).ready(function() {
  var showDropdown = false;

	$('#mobile-nav-menu').click(function() {
    if (!showDropdown) {
      $('#mobile-navbar').slideDown();
      showDropdown = true;
    } else {
      $('#mobile-navbar').slideUp();
      showDropdown = false;
    }
  });
});
