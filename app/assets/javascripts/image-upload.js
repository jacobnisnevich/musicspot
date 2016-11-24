$(document).ready(function() {

  $(document).on('click', '#group-header-photo', function() {
    $('#image-upload-popup, #blanket').fadeIn(400);
  });

  $(document).on('click', '#blanket', function() {
    $('#image-upload-popup, #blanket').fadeOut(300);
  });
});
