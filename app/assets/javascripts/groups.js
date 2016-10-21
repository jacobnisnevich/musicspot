$(document).ready(function() {
  $('#search-groups-button').click(function() {
    $.post('/groups/update', {
      name: $('#search-name-input').val()
    }, function(data) {
      updateGroups(data);
    });
  })
});

function updateGroups(groups) {
  $('#find-groups-results').empty();

  groups.forEach(function(group) {
    $('#find-groups-results').append('<div class="find-groups-results-group" data-id="' + group.id + '">' +
        '<div class="group-header">' +
          '<div class="group-name">' + group.name + '</div>' +
          '<div class="group-location">' + group.location + '</div>' +
        '</div>' +
        '<div class="group-body">' +
          '<div class="group-description">' + group.description + '</div>' +
          '<div class="group-type">' + group.group_type + '</div>' +
        '</div>' +
      '</div>');
  });
}