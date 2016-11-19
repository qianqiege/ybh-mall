$(function () {
  $(".address-confirm").on('click', function() {
    window.location = '/mall/addresses/choose?choose_address_id=' + $(this).data('address-id')
  })

  $("#confirm_order_btn").on('click', function() {
    event.preventDefault();
    $("#confirm_order").submit();
  })
});
