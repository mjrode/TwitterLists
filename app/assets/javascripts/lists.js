$("document").ready(function() {
  RED = 'rgba(232, 68, 68, 0.529412)';
  YELLOW = '#fee873';
  GREEN = 'rgba(53, 214, 37, 0.639216)';
 
  
  $('.shrink-me').each(function (index, value) { 
    $("#friend-list-options-"+index).change(function(){
      var colors = {1: GREEN, 2: YELLOW, 3: RED, 4: 'white' };
      var div = {1: '#always-on', 2: '#frequently-on', 3: '#sometimes-on'};
      var value = $(this).val();      
      $(".color-me-"+index).css('background', colors[value]);
      $("#move-me-"+index).appendTo(div[value]);
      if(value!=4){
        $("#move-hr-"+index).remove();
      }
    });

      var div = {1: '#always-on', 2: '#frequently-on', 3: '#sometimes-on'};
      var colors = {1: GREEN, 2: YELLOW, 3: RED, 4: 'white' };
      var value = $("#friend-list-options-"+index).val();      
      $(".color-me-"+index).css('background', colors[value]);
      $(".color-me-"+index).css('background', colors[value]);
      $("#move-me-"+index).appendTo(div[value]);
      if(value!=4){
        $("#move-hr-"+index).remove();
      }

  });

  $('.tweets').each(function (index, value){
      $("#reply-box-"+index).click(function(){
        $("#tweet-reply-"+index).show();
      });
  });

  $('.tweet-me').click(function (){
    $('.share').toggle();
  });

});