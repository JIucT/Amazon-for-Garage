$(document).ready( function() {
  
  $("#main-shop-link").click( function() {
    $.get("/books/index_shop", { no_layout: true }, function(data) {
      $("#main").replaceWith(data);
    }); 
  });

  $("#main-home-link").click( function() {
    $.get("/books", { no_layout: true }, function(data) {
      $("#main").replaceWith(data);
    });
  });

  function replaceMain(link) {
    $.get(link, { no_layout: true }, function(data) {
      $("#main").replaceWith(data);
    });
  }

  $(".carousel").carousel({
    interval: false
  });

  $("#main-corusel-prev").click( function() {
    $(".carousel").carousel("prev");
  });

  $("#main-corusel-next").click( function() {
    $(".carousel").carousel("next");
  });

  if (history && history.pushState){
    $(function(){
     $('body').on('click', 'a', function(e){
        $.getScript(this.href);
        history.pushState(null, '', this.href);
        return false;
      });
      $(window).on("popstate", function() {
        replaceMain(location.href);
      });
    });
  }


});