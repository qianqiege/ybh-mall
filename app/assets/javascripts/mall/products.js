$(function () {
  var $buyNum = $("#buyNum"),
      $maxNum = parseInt($("#shop_count").text());

  $("#increase_btn").on('click', function() {
    if ($maxNum === parseInt($buyNum.val())) {
      return;
    }
    $buyNum.val(parseInt($buyNum.val()) + 1)
  });

  $("#decrease_btn").on('click', function() {
    if (1 === parseInt($buyNum.val())) {
      return;
    }
    $buyNum.val(parseInt($buyNum.val()) - 1)
  });

  $("#add_cart").on('click', function() {
    $.ajax({
      type: 'POST',
      url: '/mall/line_items',
      data: { product_id: $(this).data("product_id"), quantity: parseInt($buyNum.val())},
      dataType: 'json',
      timeout: 300,
      success: function(data){
        if (data.location) {
          window.location.href = data.location;
          return;
        }
        $("#carNum").removeClass('hide');
        $("#carNum").text(parseInt($("#carNum").text()) + parseInt(data['quantity']))
        showFlash('#toast-success', '已加入购物车');
      },
      error: function(xhr, type){
        showFlash('#toast-custom', '发生错误了')
      }
    })
  })
});
