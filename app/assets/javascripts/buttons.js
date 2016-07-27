$('document').ready(function(){

  $('#select-list').hide();
  $('#show-find-list').click(function() {
      $('#center-me').toggleClass("large-offset-3");
      $("#select-list").animate({
         height: 'toggle'
      });
      $('.goaway').toggle();
  });

  $('.close').click(function(){
    $('.alert-box').toggle();
  });

  $('#appear').click(function(){
    $('.nomas').toggle();
    $('#tweets-images').toggle();
  });
});