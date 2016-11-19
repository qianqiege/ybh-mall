function line_item_add_and_remove(url, line_item_id, method, that) {
  $.ajax({
    type: method,
    url: url,
    dataType: 'json',
    success: function(data) {
      if (data.exceed) {
        showFlash('#toast-custom', data.exceed);
        return;
      }
      switch(data.action) {
        case 'add':
          that.prev().val(parseInt(that.prev().val()) + 1);
          trgger_price_change(that, data.unit_price)
          break;
        case 'remove':
          that.next().val(parseInt(that.next().val()) - 1);
          trgger_price_change(that, 0 - data.unit_price)
          break;
        case 'delete':
          that.parent().parent().remove();
          trigger_total_price_change(0 - data.current_line_item_price)
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

// 减少商品数量
$.fn.shop_count_decrease_control = function(){
  return this.each(function(){
    var $buyNum = $(this).next(),
        $maxNum = parseInt($buyNum.data("shop-count")),
        $currentNum = parseInt($buyNum.val());

    if (1 === $currentNum) {
      showFlash('#toast-custom', '最小购买数量为1');
      return;
    }


    if ( !$(this).hasClass('decrease_btn_ajax') ) {
      $buyNum.val($currentNum - 1)
    }

    if ( $(this).hasClass('decrease_btn_ajax') ) {
      var line_item_id = $(this).next().data("line_item_id"),
          url = "/mall/line_items/" + line_item_id + "/remove";

      line_item_add_and_remove(url, line_item_id, "PUT", $(this));
    }
  })
}

// 增加商品数量
$.fn.shop_count_increase_control = function(){
  return this.each(function(){
    var $buyNum = $(this).prev(),
        $maxNum = parseInt($buyNum.data("shop-count")),
        $currentNum = parseInt($buyNum.val()),
        $errorTip = "最大购买数量为" + $maxNum;

    if ( 0 === $maxNum ) {
      showFlash("#toast-custom", "没有库存了");
      return;
    }

    if ($maxNum <= $currentNum) {
      showFlash("#toast-custom", $errorTip);
      return;
    }

    if ( !$(this).hasClass('increase_btn_ajax') ) {
      $buyNum.val($currentNum + 1)
    }

    if ( $(this).hasClass('increase_btn_ajax') ) {
      var line_item_id = $(this).prev().data("line_item_id"),
          total_price = $("#total-price").text(),
          url = "/mall/line_items/" + line_item_id + "/add";

      line_item_add_and_remove(url, line_item_id, "PUT", $(this));
    }
  })
}

// 官方默认的脚本不支持zepto，且zepto不支持gt选择器，故改写
$.fn.china_city = function() {
  return this.each(function() {
    var selects;
    selects = $(this).find('.city-select');
    return selects.change(function() {
      var $this, next_selects;
      $this = $(this);
      next_selects = selects.slice(selects.index(this) + 1);
      $(next_selects).children("option").not(function() {
        return (!!$(this).eq(0).text().match(/--.*--/))
      }).remove();
      if (next_selects.first()[0] && $this.val() && !$this.val().match(/--.*--/)) {
        return $.get("/china_city/" + ($(this).val()), function(data) {
          var i, len, option;
          if (data.data != null) {
            data = data.data;
          }
          for (i = 0, len = data.length; i < len; i++) {
            option = data[i];
            next_selects.first()[0].options.add(new Option(option[0], option[1]));
          }
          return next_selects.trigger('china_city:load_data_completed');
        });
      }
    });
  });
};
