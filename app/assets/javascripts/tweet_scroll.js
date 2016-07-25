$('document').ready(function(){
  var boxes = [];
  var seen = [];
  $(".tweets").each(function(index, value){
    if ($("#reply-box-"+index).offset()){
      boxes.push({element: $(this), id: $(value).data().remoteTweetId}); 
    }
  });

  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  });

  function seen_tweet(box){
    seen.push(box);
    p('seenIt' + box.id);

    $.post('/tweets/seen', {'id': box.id}, function(response) {
      return response;
    }, 'json');

  }

  $(window).on('scroll', function(){
    var scrollTop = $(window).scrollTop();
    last = boxes.find(function(box){
      boxEnd = box.element.offset().top + box.element.height();
      if ((scrollTop > boxEnd) && !(seen.includes(box))){
        seen_tweet(box);
        console.log('seen tweet');
      }
    });
  });
});

$(window).on('beforeunload', function() {
    $(window).scrollTop(0); 
});
