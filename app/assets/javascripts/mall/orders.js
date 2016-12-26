$(function () {
  $(".address-confirm-btn").on('click', function() {
    window.location = '/mall/addresses/choose?choose_address_id=' + $(this).data('address-id')
  })

  $("#confirm_order_btn").on('click', function() {
    event.preventDefault();
    if ($.trim($("#total-price").data('all_total_price')) == "0.00") {
      $.tips('库存不足，请再等等，或购买其他商品');
      return;
    }
    showFlash('#loadingToast', '提交订单中')
    $("#confirm_order").submit();
  })
});
