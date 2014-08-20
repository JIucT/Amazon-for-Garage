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
    $(".main-shop-link").click( function() {
      replaceMain("/books/index_shop");
    });

    $(".main-home-link").click( function() {
      replaceMain("/books");
    });       
    $.each($.makeArray($("#categories li a")), function(index, elem) {        
      $("#"+elem.id).click( function() {
        replaceMain("/books/index_shop", { no_layout: true, category: elem.innerHTML })
      });    
    });

    $(".pagination-item").click( function() {
      booksCategory = location.href.match(/category=[\w+]+/);
      if (booksCategory)
        booksCategory = booksCategory[0].substr(9).replace('+', ' ');      
      replaceMain("/books/index_shop", { no_layout: true, active_page: this.id, category: booksCategory });
      if (location.href.indexOf('?') == -1)
        history.pushState(null, '', '?active_page='+this.id);
      else {
        var oldParams = location.href.substr(location.href.indexOf('?'));
        if (location.href.indexOf('active_page=') == -1) {      
          history.pushState(null, '', 'index_shop'+oldParams+'&active_page='+this.id);
        } else {
          history.pushState(null, '', 'index_shop'+oldParams.replace(/active_page=\d+/,
                                                               'active_page='+this.id));
        }
      }
    });
  }

  carouselSetUp();
  markShopCategories();

  $(".main-shop-link").click( function() {
    replaceMain("/books/index_shop");
  });

  $(".main-home-link").click( function() {
    replaceMain("/books");
  });    

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
