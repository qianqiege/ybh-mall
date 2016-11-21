// 增加商品展示中商品数量验证
$.fn.product_count_increase_control = function(){
  return this.each(function(){
    var $buyNum = $(this).prev(),
        $currentNum = parseInt($buyNum.val());

    $buyNum.val($currentNum + 1)
  })
}

// 减少商品展示中商品数量验证
$.fn.product_count_decrease_control = function(){
  return this.each(function(){
    var $buyNum = $(this).next(),
        $currentNum = parseInt($buyNum.val());

    if (1 === $currentNum) {
      $.tips('最小购买数量为1');
      return;
    }

    $buyNum.val($currentNum - 1)
  })
}

$(function () {
  $("#increase_btn").on('click', function() {
    $(this).product_count_increase_control();
  });

  $("#decrease_btn").on('click', function() {
    $(this).product_count_decrease_control();
  });

  // 加入购物车
  $("#add_cart").on('click', function() {
    var $buyNum = $("#buyNum");
    $.ajax({
      type: 'POST',
      url: '/mall/line_items',
      data: { product_id: $(this).data("product_id"), quantity: parseInt($buyNum.val())},
      dataType: 'json',
      success: function(data){
        if (data.location) {
          window.location.href = data.location;
          return;
        }
        if (data.error_messages) {
          $.tips(data.error_messages);
          $("#carNum").text(parseInt(data.cart_real_product_count))
          return;
        }
        $("#carNum").removeClass('hide');
        $("#carNum").text(parseInt(data.cart_real_product_count))
        showFlash('#toast-success', '已加入购物车');
      }
    })
  })
});
