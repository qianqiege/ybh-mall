$(function () {
  $(".address-confirm-btn").on('click', function() {
    window.location = '/mall/addresses/choose?choose_address_id=' + $(this).data('address-id')
  })

  $("#confirm_order_btn").on('click', function() {
    event.preventDefault();
    if( $("#custom_price").length > 0 && ( $.trim($("#custom_price").val()) == "" || $.trim($("#custom_price").val()) <= 0 ) ) {
      $.tips('必须填定自定义价格');
      return;
    }
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

  $(".btn-receive").on('click', function() {
    $.confirm('确定要设置为已收货吗？', function(e) {
      var id = $(this).data('id');
      if (e) {
        $.ajax({
          type: 'PUT',
          url: '/mall/orders/receive/',
          data: {id: id},
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
