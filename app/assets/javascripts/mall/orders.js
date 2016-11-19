$(function () {
  $(".address-confirm").on('click', function() {
    window.location = '/mall/addresses/choose?choose_address_id=' + $(this).data('address-id')
  })
});
