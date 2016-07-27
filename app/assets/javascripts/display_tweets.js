$('document').ready(function(){
  $('#new').click(function(){
    $('#viewed').addClass('yellow');
    $('#new').addClass('blue');

    $('.new-tweets').show();
    $('.viewed-tweets').hide();
  });

  $('#viewed').click(function(){
    console.log('hello')
    $('.new-tweets').hide();
    $('.viewed-tweets').show();

    $('#viewed').addClass('blue');
    $('#new').addClass('yellow');

  });
});