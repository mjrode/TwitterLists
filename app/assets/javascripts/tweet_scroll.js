$("document").ready(function(){
  var boxes = [];
  $(".tweets").each(function (index, value){
    var element_position = $("#reply-box-"+index).offset().top;
    boxes.push( {location: element_position, id: $(value).data().remoteTweetId})
  });

  function seen_tweet(tweet_id){
    //ajax store that we've seen
    //$.post()
    // p('seenIt' + tweet_id);
  }


  $(window).on('scroll', function() {
      var y_scroll_pos = $(window).scrollTop();
      last = boxes.find(function(box){
        if (box.location < y_scroll_pos){
          seen_tweet(box.id)
          return;
        }
      })
      //// var scroll_pos_test = element_position;

      // if(y_scroll_pos > scroll_pos_test && boxes[index] === undefined) {
      //     console.log("#reply-box-"+index);
      //     console.log($(window).scrollTop());
      //     console.log($("#reply-box-"+index).offset().top);
      //     boxes[index] = true
      // }
  });
});

// tweets will iterate and add to boxes array, the 