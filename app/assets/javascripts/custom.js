$(document).ready( function() {

  function replaceMain(link, params, id) {
    params = params || { no_layout: true }
    id = id || "main"
    $.get(link, params, function(data) {
      $("#"+id).replaceWith(data);
      if (location.pathname == '/books' || location.pathname == '/') {
        carouselSetUp();
      }
      else if (location.pathname.indexOf('/books/index_shop') == 0) {
        markShopCategories();
      }
    });
  }

  function carouselSetUp() {
    $(".carousel").carousel({
      interval: false
    });

    $("#main-corusel-prev").click( function() {
      $(".carousel").carousel("prev");
    });

    $("#main-corusel-next").click( function() {
      $(".carousel").carousel("next");
    });
  };

  function markShopCategories() {
    $.each($.makeArray($("#categories li a")), function(index, elem) {  
      $("#"+elem.id).click( function() {
        replaceMain("/books/index_shop", { no_layout: true, category: elem.innerHTML })
      });    
    });
  }

  carouselSetUp();
  markShopCategories();

  $("#main-shop-link").click( function() {
    replaceMain("/books/index_shop");
  });

  $("#main-home-link").click( function() {
    replaceMain("/books");
  })

  $(".pagination-item").click( function() {
    replaceMain("/books/index_shop", { no_layout: true, active_page: this.id });
  })


  if (history && history.pushState){
   $('body').on('click', '.internal-ref', function(e){
      history.pushState(null, '', this.href);
      return false;  //don't go by native reference
    });
    $(window).on("popstate", function() {
      replaceMain(location.href);
    });
  }

});