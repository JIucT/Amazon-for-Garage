$(document).ready( function() {
//jQuery time
var current_fs, next_fs, previous_fs; //fieldsets
var left, opacity, scale; //fieldset properties which we will animate
var animating; //flag to prevent quick multi-click glitches

$(".next").click(function(){

  if ($(this).prop('id') == "to-confirm") { 
    if (!paymantValid()) {
      $(this).blur();
      return true;      
    }
  }
  
  if ($(this).prop('id') == "to-delivery") {
    if (!addressValid()) {
      $(this).blur();
      return true;      
    }    
  }

  if(animating) return false;
  animating = true;
  
  current_fs = $(this).parent();
  next_fs = $(this).parent().next();
  
  //activate next step on progressbar using the index of next_fs
  $("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");
  
  //show the next fieldset
  next_fs.show(); 
  //hide the current fieldset with style
  current_fs.animate({opacity: 0}, {
    step: function(now, mx) {
      //as the opacity of current_fs reduces to 0 - stored in "now"
      //1. scale current_fs down to 80%
      scale = 1 - (1 - now) * 0.2;
      //2. bring next_fs from the right(50%)
      left = (now * 50)+"%";
      //3. increase opacity of next_fs to 1 as it moves in
      opacity = 1 - now;
      current_fs.css({'transform': 'scale('+scale+')'});
      next_fs.css({'left': left, 'opacity': opacity});
    }, 
    duration: 800, 
    complete: function(){
      current_fs.hide();
      animating = false;
    }, 
    //this comes from the custom easing plugin
    easing: 'easeInOutBack'
  });
});

function paymantValid() {
  var errors = false; 
  if (!/(\d{4}[\s-]{0,1}){3}\d{4}/.test($("#paymant input[name='credit-card']").val())) {
    markError("#paymant input[name='credit-card']");
    errors = true;    
  }
  if ($("#paymant #card-exp-month option:selected").prop('disabled') == true) {
    markError("#paymant #card-exp-month");      
    $("#paymant #card-exp-month").on('change', function() {
      $(this).css("box-shadow", "0 0 0 0");
    });
    errors = true;
  }  
  if ($("#paymant #card-exp-year option:selected").prop('disabled') == true) {
    markError("#paymant #card-exp-year");      
    $("#paymant #card-exp-year").on('change', function() {
      $(this).css("box-shadow", "0 0 0 0");
    });
    errors = true;
  }
  var cvc = $("#paymant input[name='CVC']");
  if (!/\d{3}/.test(cvc.val())) {
    markError("#paymant input[name='CVC']");
    errors = true;    
  }  
  return !errors;
}

function addressValid() {
  var errors = false;  
  if (!/[A-z\s-]{2,}/.test($("#bil-addr #firstname").val())) {
    markError("#bil-addr #firstname");
    errors = true;
  }
  if (!/[A-z\s-]{2,}/.test($("#bil-addr #lastname").val())) {
    markError("#bil-addr #lastname");      
    errors = true;
  }
  if (!/[A-z\s-,]{2,}/.test($("#bil-addr #bill-st-addr").val())) {
    markError("#bil-addr #bill-st-addr");      
    errors = true;
  }
  if (!/[A-z\s-]{2,}/.test($("#bil-addr #bill-city-addr").val())) {
    markError("#bil-addr #bill-city-addr");      
    errors = true;
  }
  if (!/\d{4,6}/.test($("#bil-addr #bill-zip").val())) {
    markError("#bil-addr #bill-zip");      
    errors = true;
  }  
  if (!/[0-9+\s-]{9,20}/.test($("#bil-addr #bill-phone").val())) {
    markError("#bil-addr #bill-phone");      
    errors = true;
  }  
  if ($("#bil-addr .countries-select option:selected").prop('disabled') == true) {
    markError("#bil-addr .countries-select");      
    $("#bil-addr .countries-select").on('change', function() {
      $(this).css("box-shadow", "0 0 0 0");
    });
    errors = true;
  }
  if (!$("#use-billing-address").is(":checked")) {
    if (!/[A-z\s-]{2,}/.test($("#shipping-address #ship-firstname").val())) {
      markError("#shipping-address #ship-firstname");
      errors = true;
    }
    if (!/[A-z\s-]{2,}/.test($("#shipping-address #ship-lastname").val())) {
      markError("#shipping-address #ship-lastname");      
      errors = true;
    }
    if (!/[A-z\s-,]{2,}/.test($("#shipping-address #ship-st-addr").val())) {
      markError("#shipping-address #ship-st-addr");      
      errors = true;
    }
    if (!/[A-z\s-]{2,}/.test($("#shipping-address #ship-city-addr").val())) {
      markError("#shipping-address #ship-city-addr");      
      errors = true;
    }
    if (!/\d{4,6}/.test($("#shipping-address #ship-zip").val())) {
      markError("#shipping-address #ship-zip");      
      errors = true;
    }  
    if ($("#shipping-address .countries-select option:selected").prop('disabled') == true) {
      markError("#shipping-address .countries-select");      
      $("#shipping-address .countries-select").on('change', function() {
        $(this).css("box-shadow", "0 0 0 0");
      });
      errors = true;
    }        
  }
  return !errors;
}

function markError(elementId) {
  $(elementId).css("box-shadow", "0 0 0 3px red");
  $(elementId).on('input', function() {
    $(this).css("box-shadow", "0 0 0 0");
  });
}

$(".previous").click(function(){
  if(animating) return false;
  animating = true;
  
  current_fs = $(this).parent();
  previous_fs = $(this).parent().prev();
  
  //de-activate current step on progressbar
  $("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");
  
  //show the previous fieldset
  previous_fs.show(); 
  //hide the current fieldset with style
  current_fs.animate({opacity: 0}, {
    step: function(now, mx) {
      //as the opacity of current_fs reduces to 0 - stored in "now"
      //1. scale previous_fs from 80% to 100%
      scale = 0.8 + (1 - now) * 0.2;
      //2. take current_fs to the right(50%) - from 0%
      left = ((1-now) * 50)+"%";
      //3. increase opacity of previous_fs to 1 as it moves in
      opacity = 1 - now;
      current_fs.css({'left': left});
      previous_fs.css({'transform': 'scale('+scale+')', 'opacity': opacity});
    }, 
    duration: 800, 
    complete: function(){
      current_fs.hide();
      animating = false;
    }, 
    //this comes from the custom easing plugin
    easing: 'easeInOutBack'
  });
});

});