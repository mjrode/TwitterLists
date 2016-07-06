$("document").ready(function(){
  $(".tweets").each(function (index, value){

    var element_position = $("#reply-box-"+index).offset().top;

    $(window).on('scroll', function() {
        var y_scroll_pos = $(window).scrollTop();
        var scroll_pos_test = element_position;

        if(y_scroll_pos > scroll_pos_test) {
            console.log("#reply-box-"+index);
            console.log($(window).scrollTop());
            console.log($("#reply-box-"+index).offset().top);
        }
    });
  });
});