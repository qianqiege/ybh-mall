$(function () {
  $(".address-confirm-btn").on('click', function() {
    window.location = '/mall/addresses/choose?choose_address_id=' + $(this).data('address-id')
  })

  $("#confirm_order_btn").on('click', function() {
    event.preventDefault();
    showFlash('#loadingToast', '提交订单中')
    $("#confirm_order").submit();
  })

  $("#return_request_btn").on('click', function() {
    $("#new_return_request").submit();
  })

  $(".btn-cancel").on('click', function() {
    $.confirm('确定要取消此订单吗？', function(e) {
      var id = $(this).data('id');
      if (e) {
        $.ajax({
          type: 'POST',
          url: '/mall/orders/' + id + '/make_cancel',
          data: {},
          dataType: 'json',
          success: function(data) {
            window.location.reload();
          },
          error: function() {
            $.tips('出错了');
          }
        })
      }
    }.bind(this));
  })
});
