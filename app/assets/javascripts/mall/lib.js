function line_item_add_and_remove(url, line_item_id, total_price, method, that) {
  $.ajax({
    type: method,
    url: url,
    data: { id: parseInt(line_item_id), total_price: total_price },
    dataType: 'json',
    success: function(data) {
      if (data.exceed) {
        showFlash('#toast-custom', data.exceed);
        return;
      }
      $("#total-price").text(data.total_price);
    },
    error: function(xhr, type){
      showFlash('#toast-custom', '发生错误了')
    }
  })
}

$.fn.shop_count_decrease_control = function(){
  return this.each(function(){
    var $buyNum = $(this).next(),
        $currentNum = parseInt($buyNum.val());
    if (1 === $currentNum) {
      showFlash('#toast-custom', '最小购买数量为1');
      return;
    }

    $buyNum.val($currentNum - 1)

    if ( $(this).hasClass('decrease_btn_ajax') ) {
      var line_item_id = $(this).next().data("line_item_id"),
          total_price = $("#total-price").text(),
          url = "/mall/line_items/" + line_item_id + "/remove";

      line_item_add_and_remove(url, line_item_id, total_price, "PUT", $(this));
    }
  })
}

$.fn.shop_count_increase_control = function(){
  return this.each(function(){
    var $buyNum = $(this).prev(),
        $maxNum = parseInt($buyNum.data("shop-count")),
        $currentNum = parseInt($buyNum.val()),
        $errorTip = "最大购买数量为" + $maxNum;
    if ($maxNum <= $currentNum) {
      showFlash("#toast-custom", $errorTip);
      return;
    }

    $buyNum.val($currentNum + 1)

    if ( $(this).hasClass('increase_btn_ajax') ) {
      var line_item_id = $(this).prev().data("line_item_id"),
          total_price = $("#total-price").text(),
          url = "/mall/line_items/" + line_item_id + "/add";

      line_item_add_and_remove(url, line_item_id, total_price, "PUT", $(this));
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
