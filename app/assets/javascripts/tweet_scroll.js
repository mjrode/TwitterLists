$('document').ready(function(){
  var boxes = [];
  var seen = [];
  $(".tweets").each(function(index, value){
    var element_position = $("#reply-box-"+index).offset().top;
    boxes.push({location: element_position, id: $(value).data().remoteTweetId});
  });

  function seen_tweet(box){
    seen.push(box);
    p('seenIt' + box.id);
    $.post('/tweets/seen', box, function(response) {
      return response;
    }, 'json');

  }

  $(window).on('scroll', function(){
    var scrollTop = $(window).scrollTop() + 100;
    var scrollBottom = $(window).scrollTop() + $(window).height() - 100;
    last = boxes.find(function(box){
      if ((scrollBottom > box.location) && (scrollTop < box.location)&& !(seen.includes(box))){
        seen_tweet(box);
      }
    });
  });
});
