$(function () {
  $(".increase_btn_ajax").on('click', function() {
    $(this).shop_count_increase_control();
  })

  $(".decrease_btn_ajax").on('click', function() {
    $(this).shop_count_decrease_control();
  })

  $(".del").on('click', function() {
    var line_item_id = $(this).data("line_item_id"),
        total_price = $("#total-price").text();
        url = "/mall/line_items/" + line_item_id;
    $.confirm('确定要删除此商品吗？', function(e) {
      if (e) {
        line_item_add_and_remove(url, line_item_id, "DELETE", $(this));
      }
    }.bind(this));
  })

  $("#clearing_commit").on('click', function() {
    event.preventDefault();
    $("#show_cart").submit();
  })

  $(".choose").on('click', function() {
    var textEle = $('.cart_check_all_line_item', this),
        radioEle = $('.radio', this),
        totalEle = $("#total-price"),
        allLineItemRadioEle = $(".pro-list-portrait .radio"),
        allHiddenInputEle = $(".pro-list-portrait .line_item_hidden_input");

    if ( "全部取消" == textEle.text() ) {
      textEle.text("全部选中");
    } else {
      textEle.text("全部取消");
    }

    radioEle.toggleClass('setDef');

    if ( radioEle.hasClass('setDef') ) {
      totalEle.text(totalEle.data('all_total_price'));
      allLineItemRadioEle.addClass('setDef');
      allHiddenInputEle.val(allHiddenInputEle.data("line-item-id"));
    } else {
      totalEle.text("0.00");
      allLineItemRadioEle.removeClass('setDef');
      allHiddenInputEle.val("");
    }
  })

  $('.radio_btn').on('click', function() {
    var currentLineItemPriceVal = $(this).data('current-line-item-price'),
        totalPriceEle = $("#total-price"),
        hiddenInputEle = $(this).parent().find(".line_item_hidden_input");

    $(this).toggleClass('setDef');

    if ( $(this).hasClass('setDef') ) {
      totalPriceEle.text( (totalPriceEle.text() - 0 + parseFloat(currentLineItemPriceVal)).formatMoney() );
      hiddenInputEle.val(hiddenInputEle.data('current-line-item-price'));
    } else {
      totalPriceEle.text( (totalPriceEle.text() - 0 - parseFloat(currentLineItemPriceVal)).formatMoney() );
      hiddenInputEle.val("");
    }
  })
});
