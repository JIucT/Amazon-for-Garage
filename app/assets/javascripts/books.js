$(document).ready( function() {
  $(".spinedit").on( 'input', function() {
    if ( !/^\d*$/.test($(this).val()) )
      $(this).val("1");
  });

  $(".spinedit").click( function() {
    $(this).select();
  });

  $("#add-to-cart").click( function() {
    var bookId = (location.pathname.substr(location.pathname.lastIndexOf('/')+1)).match(/\d+/);
    var booksNumber = $(".spinedit").val();
    var value;
    if ($.cookie('ordered_items')) 
      value = $.cookie('ordered_items')+bookId+'|'+booksNumber+',';         
    else
      value = bookId+'|'+booksNumber+',';      
    $.cookie('ordered_items', value, { path: '/' });
    $("#cart-status").html($.cookie('ordered_items').match(/\,/g).length);
  });

  $("#add-review").click( function() {
    $("#review-form").slideToggle('slow');
    return false;
  });

  $("#send-review").click( function() {
    var ratingVal, titleVal, commentVal;
    ratingVal = $("#review-form .star:checked").val();
    if (ratingVal == undefined) {
      alert("Please, select rating");
      return;
    }
    titleVal = $("#review-form #short-feedback").val();
    if (titleVal == '') {
      alert("Please, enter short feedback");
      return;
    }
    commentVal = $("#review-form #comment").val();
    var bookId = (location.pathname.substr(location.pathname.lastIndexOf('/')+1)).match(/\d+/)[0];    
    $.post("/ratings", { 
      rating: { 
        mark: ratingVal, 
        title: titleVal, 
        comment: commentVal, 
        book_id: bookId 
        } 
      }, function(data) {
      $("#review-form").replaceWith(data);
      $("#add-review").hide();
      $('input[type="radio"].star').rating();       
    });
  });
});
