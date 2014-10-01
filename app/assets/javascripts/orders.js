$(document).ready( function() {
  $(".remove_item").click( function() {
    newValue = $.cookie('ordered_items').replace( this.id, "");
    if (newValue == "")
      $.removeCookie('ordered_items', { path: '/' });
    else
      $.cookie('ordered_items', newValue, { path: '/' });
    this.parentNode.parentNode.remove();
  });

  $("#empty-cart").click( function() {
    $.removeCookie('ordered_items', { path: '/' });
    $(".item-in-cart").remove();
  });

  $("#use-billing-address").bind("change", function() {
      $("#shipping-address").toggle("slow");
  });

  $("#to-delivery").click( function() {
    if ($("#use-billing-address").is(":checked")) {
      var country;
      $("#shipping-address #ship-firstname").val($("#bil-addr #firstname").val());
      $("#shipping-address #ship-lastname").val($("#bil-addr #lastname").val());
      $("#shipping-address #ship-st-addr").val($("#bil-addr #bill-st-addr").val());
      $("#shipping-address #ship-city-addr").val($("#bil-addr #bill-city-addr").val());
      $("#shipping-address #ship-zip").val($("#bil-addr #bill-zip").val());
      country = $("#bil-addr .countries-select option:selected").val();
      $("#shipping-address .countries-select option[value='" + country + "']").prop('selected', true);
    }
  });
 
  $("#back-to-address").click( function() {
    if ($("#use-billing-address").is(":checked")) {
      $("#shipping-address #ship-firstname").val("");
      $("#shipping-address #ship-lastname").val("");
      $("#shipping-address #ship-st-addr").val("");
      $("#shipping-address #ship-city-addr").val("");
      $("#shipping-address #ship-zip").val("");
      $("#shipping-address .countries-select option[value=Country]").prop('selected', true);
    }
  });

  var radButtons = $("input[name='delivery']");
  
  radButtons.each( function(item) {
    $(this).bind("click", function() {
      $(".ship-price").text($(this).val());
      $(".total-price").text(parseFloat($(this).val()) + parseFloat($(".item-price").text().replace('$','')));
    });
  });

  $("#whats-it").tooltip({
    show: {
      effect: "Explode",
      delay: 250
    }
  });

  $("#to-confirm").click( function() {
    var deliveryType, cardNumber, cardExpYear, cardExpMonth;
    $("#billing-address-confirm .name").text($("#firstname").val() + " " + $("#lastname").val());
    $("#billing-address-confirm .street").text($("#bill-st-addr").val());
    $("#billing-address-confirm .city").text($("#bill-city-addr").val() + ", " + $("#bill-zip").val());
    $("#billing-address-confirm .country").text($("#bil-addr .countries-select option:selected").val());
    $("#billing-address-confirm .phone").text("Phone " + $("#bill-phone").val());

    $("#shipping-address-confirm .name").text($("#ship-firstname").val() + " " + $("#ship-lastname").val());
    $("#shipping-address-confirm .street").text($("#ship-st-addr").val());
    $("#shipping-address-confirm .city").text($("#ship-city-addr").val() + ", " + $("#ship-zip").val());
    $("#shipping-address-confirm .country").text($("#shipping-address .countries-select option:selected").val());         
    deliveryType = $("#delivery-type input[type='radio']:checked").parent().text();
    $("#ship-type-conf").text(deliveryType.substring(0, deliveryType.indexOf('+')-1));
    cardNumber = $("div input[name='credit-card']").val();
    $("#card-num-conf").text("** ** ** " + cardNumber.substr(cardNumber.length-4));
    cardExpYear = $("#card-exp-year option:selected").val();
    cardExpMonth = $("#card-exp-month option:selected").val();
    $("#card-exp-conf").text(cardExpYear + "/" + cardExpMonth);
  });

  $("input[name='submit-order']").click( function() {
    var shippingType = $("#delivery-type input:checked").parent().text();
    $.post("/orders", {
      order: { 
        total_price: $("#price").text().replace('$',''),
        bil_street:  $("#bill-st-addr").val(),
        bil_city: $("#bill-city-addr").val(),
        bil_zip: $("#bill-zip").val(),
        bil_country: $("#bil-addr .countries-select option:selected").val(),
        bil_mobile: $("#bill-phone").val(),
        
        ship_street: $("#shipping-address #ship-st-addr").val(),
        ship_city: $("#shipping-address #ship-city-addr").val(),
        ship_zip: $("#shipping-address #ship-zip").val(),
        ship_country: $("#shipping-address .countries-select option:selected").val(),

        card_number: $("#paymant input[name='credit-card']").val().replace(/\s/g, ""),
        card_exp_month: $("#paymant #card-exp-month option:selected").val(),
        card_exp_year: $("#paymant #card-exp-year option:selected").val(),

        shipping_type: shippingType.substring(0, shippingType.indexOf('+')-1).trim()
      }       
    }, function(data) {
      $("body").replaceWith(data);
    }
      );
  });
});