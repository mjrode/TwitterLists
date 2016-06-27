$("document").ready(function() {
 
  $('#select-list').hide();
  $('#show-find-list').click(function() {
      // $('#select-list').toggle()
      $("#select-list").animate({
         height: 'toggle'
      });
      $('.goaway').toggle();
  });
  

  $('.shrink-me').each(function (index, value) { 
    $("#friend-list-options-"+index).change(function(){
      var colors = {1: 'rgba(53, 214, 37, 0.639216)', 2: '#fee873', 3: 'rgba(232, 68, 68, 0.529412)', 4: 'white' };
      var div = {1: '#always-on', 2: '#frequently-on', 3: '#sometimes-on'};
      var value = $(this).val();      
      $(".color-me-"+index).css('background', colors[value]);
      $("#move-me-"+index).appendTo(div[value]);
      if(value!=4){
        $("#move-hr-"+index).remove();
      }
    });

      var div = {1: '#always-on', 2: '#frequently-on', 3: '#sometimes-on'};
      var colors = {1: 'rgba(53, 214, 37, 0.639216)', 2: '#fee873', 3: 'rgba(232, 68, 68, 0.529412)', 4: 'white' };
      var value = $("#friend-list-options-"+index).val();      
      $(".color-me-"+index).css('background', colors[value]);
      $(".color-me-"+index).css('background', colors[value]);
      $("#move-me-"+index).appendTo(div[value]);
      if(value!=4){
        $("#move-hr-"+index).remove();
      }

  });




});

