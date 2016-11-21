function line_item_add_and_remove(url, line_item_id, method, that) {
  $.ajax({
    type: method,
    url: url,
    dataType: 'json',
    success: function(data) {
      if (data.error_messages) {
        $.tips(data.error_messages);
      }
      switch(data.action) {
        case 'add':
          trgger_price_change(that, data.price)
          that.prev().val(data.quantity);
          break;
        case 'remove':
          trgger_price_change(that, 0 - data.price)
          that.next().val(data.quantity);
          break;
        case 'delete':
          window.location.reload();
          break;
      }
    }
  })
}

function trgger_price_change(that, price) {
  var radioEle = that.parent().parent().parent().find('.radio');
  radioEle.data( 'current-line-item-price', (radioEle.data('current-line-item-price') - 0 + parseFloat(price)).formatMoney() );

  var totalPriceEle = $("#total-price");

  if (radioEle.hasClass('setDef')) {
    totalPriceEle.text( (totalPriceEle.text() - 0 + parseFloat(price)).formatMoney() );
  }

  totalPriceEle.data( 'all_total_price', (totalPriceEle.data('all_total_price') - 0 + parseFloat(price)).formatMoney() );
}

$(function () {
  // 增加购物车商品数目
  $(".increase_btn_ajax").on('click', function() {
    var line_item_id = $(this).prev().data("line_item_id"),
        url = "/mall/line_items/" + line_item_id + "/add";

    line_item_add_and_remove(url, line_item_id, "PUT", $(this));
  })

  // 减少购物车商品数目
  $(".decrease_btn_ajax").on('click', function() {
    var line_item_id = $(this).next().data("line_item_id"),
        url = "/mall/line_items/" + line_item_id + "/remove";

    var $buyNum = $(this).next(),
        $currentNum = parseInt($buyNum.val());

    if (1 === $currentNum) {
      $.tips('最小购买数量为1');
      return;
    }

    line_item_add_and_remove(url, line_item_id, "PUT", $(this));
  })

  // 删除商品
  $(".del").on('click', function() {
    var line_item_id = $(this).data("line_item_id"),
        url = "/mall/line_items/" + line_item_id;

    $.confirm('确定要删除此商品吗？', function(e) {
      if (e) {
        line_item_add_and_remove(url, line_item_id, "DELETE", $(this));
      }
    }.bind(this));
  })

  // 购物车到确认订单
  $("#clearing_commit").on('click', function() {
    event.preventDefault();
    var allLineItemRadioEle = $(".pro-list-portrait .radio");
    if (!allLineItemRadioEle.hasClass('setDef') || $.trim($("#total-price").data('all_total_price')) == "0.00") {
      showFlash('#toast-custom', '请至少选择一个商品');
      return;
    }
    showFlash('#loadingToast', '确认订单中')
    $("#show_cart").submit();
  })

  // 全选商品
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

  // 选择商品
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
