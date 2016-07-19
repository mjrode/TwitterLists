$('document').ready(function(){
  var boxes = [];
  var seen = [];
  $(".tweets").each(function(index, value){
    var element_position = $("#reply-box-"+index).offset().top;
    boxes.push({location: element_position, id: $(value).data().remoteTweetId});
  });

  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  });

  function seen_tweet(box){
    seen.push(box);
    p('seenIt' + box.id);
    $.post('/tweets/seen', box, function(response) {
      return response;
    }, 'json');

  }

  $(window).on('scroll', function(){
    var scrollTop = $(window).scrollTop();
    last = boxes.find(function(box){
      if ((scrollTop > box.location) && !(seen.includes(box))){
        seen_tweet(box);
      }
    });
  });
});

$(window).on('beforeunload', function() {
    $(window).scrollTop(0); 
});
