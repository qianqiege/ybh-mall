$(function () {
  $("#increase_btn").on('click', function() {
    $(this).shop_count_increase_control();
  });

  $("#decrease_btn").on('click', function() {
    $(this).shop_count_decrease_control();
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
        if (data.exceed) {
          showFlash('#toast-custom', data.exceed);
          return;
        }
        $("#carNum").removeClass('hide');
        $("#carNum").text(parseInt($("#carNum").text()) + parseInt(data['quantity']))
        showFlash('#toast-success', '已加入购物车');
      }
    })
  })
});
