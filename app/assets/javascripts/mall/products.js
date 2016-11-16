$(function () {
  $(".increase_btn").on('click', function() {
    var $buyNum = $(this).prev(),
        $maxNum = parseInt($buyNum.data("shop-count")),
        $currentNum = parseInt($buyNum.val()),
        $errorTip = "最大购买数量为" + $maxNum;
    if ($maxNum === $currentNum) {
      showFlash("#toast-custom", $errorTip);
      return;
    }
    $buyNum.val($currentNum + 1)
  });

  $(".decrease_btn").on('click', function() {
    var $buyNum = $(this).next(),
        $currentNum = parseInt($buyNum.val());
    if (1 === $currentNum) {
      showFlash('#toast-custom', '最小购买数量为1');
      return;
    }
    $buyNum.val($currentNum - 1)
  });

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
        if (data.exceed) {
          showFlash('#toast-custom', data.exceed);
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
