$("document").ready(function() {
  var RED = 'rgba(232, 68, 68, 0.529412)';
  var YELLOW = '#fee873';
  var GREEN = 'rgba(53, 214, 37, 0.639216)';
 
  $('#select-list').hide();
  $('#show-find-list').click(function() {
      // $('#select-list').toggle()
      $("#select-list").animate({
         height: 'toggle'
      });
      $('.goaway').toggle();
  });
  $('.close').click(function(){
    $('.alert-box').toggle();
  });
  
  $('.shrink-me').each(function (index, value) { 
    $("#friend-list-options-"+index).change(function(){
      var colors = {'always_on': GREEN, 'frequently_on': YELLOW, 'sometimes_on': RED, 'never-on': 'white' };
      var div = {'always_on': '#always-on', 'frequently_on': '#frequently-on', 'sometimes_on': '#sometimes-on'};
      var value = $(this).val();      
      $(".color-me-"+index).css('background', colors[value]);
      $("#move-me-"+index).appendTo(div[value]);
      console.log("click worked");
      if(value != 'default'){
        $("#move-hr-"+index).remove();
      }
    });

      var colors = {'always_on': GREEN, 'frequently_on': YELLOW, 'sometimes_on': RED, 'never-on': 'white' };
      var div = {'always_on': '#always-on', 'frequently_on': '#frequently-on', 'sometimes_on': '#sometimes-on'};
      var value = $("#friend-list-options-"+index).val();      
      $(".color-me-"+index).css('background', colors[value]);
      $(".color-me-"+index).css('background', colors[value]);
      $("#move-me-"+index).appendTo(div[value]);
      if(value != 'default'){
        $("#move-hr-"+index).remove();
      }

  });




});

