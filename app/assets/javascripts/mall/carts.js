// 购物车页面，增加和减少商品数量，删除商品
function line_item_add_and_remove(url, line_item_id, method, that, quantity) {
  $.ajax({
    type: method,
    url: url,
    data: { quantity: quantity },
    dataType: 'json',
    success: function(data) {
      if (data.error_messages) {
        $.tips(data.error_messages);
      }
      switch(data.action) {
        case 'add':
          trgger_price_change(that, data.price)
          that.prev().val(data.quantity);
          that.prev().data("quantity", data.quantity);
          break;
        case 'remove':
          trgger_price_change(that, 0 - data.price)
          that.next().val(data.quantity);
          that.next().data("quantity", data.quantity);
          break;
        case 'delete':
          window.location.reload();
          break;
      }
    }
  })
}

// 由line_item_add_and_remove调用，只需要传入金额就可以设置购物车的动态金额变化效果
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

    line_item_add_and_remove(url, line_item_id, "PUT", $(this), 1);
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

    line_item_add_and_remove(url, line_item_id, "PUT", $(this), 1);
  })

  // 更改商品的数量
  $(".buyNum").on('keyup', function() {
    var line_item_id = $(this).data("line_item_id"),
        $currentNum = $(this).val(),
        $databaseNum = parseInt($(this).data("quantity")),
        $databaseShopCount = parseInt($(this).data("shop-count"));

    if ("" == $currentNum || parseInt($currentNum) == $databaseNum) {
      return;
    }

    if (!isNumber($currentNum)) {
      $.tips('不能输入非数字');
      $(this).val($databaseNum);
      return;
    }

    if (parseInt($currentNum) <= 0) {
      $.tips('最小购买数量为1');
      $(this).val($databaseNum);
      return;
    }

    if (parseInt($currentNum) > $databaseShopCount) {
      $.tips('最大购买数量为' + $databaseShopCount);
      $(this).val($databaseNum);
      return;
    }

    if (parseInt($currentNum) > $databaseNum) {
      // 增加商品
      var quantity = parseInt($currentNum) - $databaseNum,
          url = "/mall/line_items/" + line_item_id + "/add";

      line_item_add_and_remove(url, line_item_id, "PUT", $(this).next(), quantity);
    } else {
      var quantity = $databaseNum - parseInt($currentNum),
          url = "/mall/line_items/" + line_item_id + "/remove";

      line_item_add_and_remove(url, line_item_id, "PUT", $(this).prev(), quantity);
    }

  })

  // 删除商品
  $(".del").on('click', function() {
    var line_item_id = $(this).data("line_item_id"),
        url = "/mall/line_items/" + line_item_id;

    $.confirm('确定要删除此商品吗？', function(e) {
      if (e) {
        line_item_add_and_remove(url, line_item_id, "DELETE", $(this), 1);
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
      allHiddenInputEle.each(function() {
        $(this).val( $(this).data("line-item-id") );
      })
    } else {
      totalEle.text("0.00");
      allLineItemRadioEle.removeClass('setDef');
      allHiddenInputEle.each(function() {
        $(this).val("");
      })
    }
  })

  // 选择商品
  $('.radio_btn').on('click', function() {
    var currentLineItemPriceVal = $(this).data('current-line-item-price'),
        totalPriceEle = $("#total-price"),
        hiddenInputEle = $(this).parent().find(".line_item_hidden_input");

    if ( $(this).hasClass('setDef') ) {
      $(this).removeClass('setDef');
      totalPriceEle.text( (totalPriceEle.text() - 0 - parseFloat(currentLineItemPriceVal)).formatMoney() );
      hiddenInputEle.val("");
    } else {
      $(this).addClass('setDef');
      totalPriceEle.text( (totalPriceEle.text() - 0 + parseFloat(currentLineItemPriceVal)).formatMoney() );
      hiddenInputEle.val(hiddenInputEle.data('current-line-item-price'));
    }
  })
});
