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

// 加入购物车和立即购买的请求
function add_cart_ajax(data) {
  $.ajax({
    type: 'POST',
    url: '/mall/line_items',
    data: data,
    dataType: 'json',
    success: function(data){
      // xhr?
      if (data.location) {
        window.location.href = data.location;
        return;
      }

      // 有错误时
      if (data.error_messages) {
        $.tips(data.error_messages);
        $("#carNum").text(parseInt(data.cart_real_product_count))
        return;
      }

      // 点击直接购买时
      if (data.fast_buy) {
        window.location.href = '/mall/cart';
        return;
      }

      $("#carNum").removeClass('hide');
      $("#carNum").text(parseInt(data.cart_real_product_count))
      showFlash('#toast-success', '已加入购物车');
    }
  })
}

$(function () {
  // 在购物车中增加商品数量
  $("#increase_btn").on('click', function() {
    $(this).product_count_increase_control();
  });

  // 在购物车中减少商品数量
  $("#decrease_btn").on('click', function() {
    $(this).product_count_decrease_control();
  });

  // 加入购物车
  $("#add_cart").on('click', function() {
    var $buyNum = $("#buyNum"),
        data = { product_id: $(this).data("product_id"), quantity: parseInt($buyNum.val()) };

    add_cart_ajax(data);
  })

  // 立即购买
  $("#fast-buy-btn").on('click', function() {
    var $buyNum = $("#buyNum"),
        data = { product_id: $(this).data("product_id"), quantity: parseInt($buyNum.val()), fast_buy: true };
    add_cart_ajax(data);
  })
});
