$(document).ready( function() {
  $(".spinedit").on( 'input', function() {
    if ( !/^\d*$/.test($(this).val()) )
      $(this).val("1");
  });

  $(".spinedit").click( function() {
    $(this).select();
    console.log($.cookie());
  });

  $("#add-to-cart").click( function() {
    var bookId = location.pathname.substr(location.pathname.lastIndexOf('/')+1);
    var booksNumber = $(".spinedit").val();
    var value;
    if ($.cookie('ordered_items') === 'undefined') 
      value = bookId+'|'+booksNumber+',';
    else
      value = $.cookie('ordered_items')+bookId+'|'+booksNumber+',';      
    $.cookie('ordered_items', value, { path: '/' });
    $("#cart-status").html($.cookie('ordered_items').match(/\,/g).length);
    console.log($.cookie());    
  });
});
