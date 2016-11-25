$(document).ready(function() {

  $(document).on('click', '#group-header-photo', function() {
    $('#image-upload-popup, #blanket').fadeIn(400);
    $('#image-upload-submit').on('click', { path: "/groups/change_image" }, onSumbitClicked);

    // Reset form fields and info to be blank
    $('#image-upload-info').text('');
    $('#image-upload-text').val('');
    var fileInput = $('#image-upload-file');
    fileInput.val('');
    fileInput.on('change', function() {
      var file = fileInput.get(0).files[0];
      if (file)
        $('#image-upload-info').text(file.name);
    });
  });

  $(document).on('click', '#blanket', function() {
    $('#image-upload-popup, #blanket').fadeOut(300);
    $('#image-upload-submit').off('click');
  });
});

function onSumbitClicked(event) {
  var file = document.getElementById('image-upload-file').files[0];
  var url = document.getElementById('image-upload-text').value;
  if (file)
    upload(file, event.data.path);
  else if (url)
    upload(url, event.data.path);
  else
    $('#image-upload-info').text("No image selected.");
}

function upload(file, path) {
  $('#image-upload-info').text("Uploading...");

  var fd = new FormData();
  fd.append("image", file);

  var xhr = new XMLHttpRequest();
  xhr.open('POST', 'https://api.imgur.com/3/image.json');
  xhr.setRequestHeader('Authorization', 'Client-ID b9a51e9d42c8869');
  xhr.onload = function() {
    if (this.status == 200) {
      var link = JSON.parse(xhr.responseText).data.link;
      $.ajax({
        url: path,
        method: 'POST',
        data: {
          id: $('#image-upload-popup').data('id'),
          image_url: link
         },
        error: function() {
          $('#image-upload-info').text("Error Type 2. Please try again.");
        }
      });
    } else {
      $('#image-upload-info').text("Error. Please try again.");
    }
  }
  xhr.send(fd);
}
