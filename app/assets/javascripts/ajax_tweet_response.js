$(document).ready(function(){
  $('.tweet-form').on('submit', function(e) {
    e.preventDefault();
    var data = $(this).serialize();
    $(this).parents('.tweets').velocity("fadeOut", { duration: 500 });
    $.post('/replies/create', data, function(response) {
      return response
    }, 'json');
  });
});

$(document).ready(function(){
  $('.share-form').on('submit', function(e) {
    e.preventDefault();
    var data = $(this).serialize();
    $(this).hide();
    $.post('/tweets/share', data, function(response) {
      return response
    }, 'json');
  });
});