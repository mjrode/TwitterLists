$("document").ready(function() {
  const RED = 'rgba(232, 68, 68, 0.529412)';
  const YELLOW = '#fee873';
  const GREEN = 'rgba(53, 214, 37, 0.639216)';
 
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




});

