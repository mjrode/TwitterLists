$("document").ready(function() {
 
  $('#select-list').hide();
  $('#show-find-list').click(function() {
      // $('#select-list').toggle()
      $("#select-list").animate({
         height: 'toggle'
      });
  });
  

  $('.shrink-me').each(function (index, value) { 
    $("#friend-list-options-"+index).change(function(){
      var colors = {1: 'rgba(53, 214, 37, 0.639216)', 2: '#fee873', 3: 'rgba(232, 68, 68, 0.529412)', 4: 'white' };
      var value = $(this).val()      
      $(".color-me-"+index).css('background', colors[value]);
    });

      var colors = {1: 'rgba(53, 214, 37, 0.639216)', 2: '#fee873', 3: 'rgba(232, 68, 68, 0.529412)', 4: 'white' };
      var value = $("#friend-list-options-"+index).val()      
      $(".color-me-"+index).css('background', colors[value]);
  });


});

