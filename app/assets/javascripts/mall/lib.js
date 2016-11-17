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
