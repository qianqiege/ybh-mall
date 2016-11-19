$(function () {
  $(".address-confirm").on('click', function() {
    window.location = '/mall/addresses/choose?choose_address_id=' + $(this).data('address-id')
  })

  $("#confirm_order_btn").on('click', function() {
    event.preventDefault();
    showFlash('#loadingToast', '提交订单中')
    $("#confirm_order").submit();
  })
});
