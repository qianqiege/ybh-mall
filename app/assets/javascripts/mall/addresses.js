$(function () {
  // 创建和编辑收货地址
  $("#create_address_btn").on('click', function(event) {
    event.preventDefault();

    if ($("#new_address").length > 0) {
      $("#new_address").submit();
      return;
    }

    if ($(".edit_address").length > 0) {
      $(".edit_address").submit();
      return;
    }
  })

  // 省城区选择器
  if ( $('.city-group').length > 0 ) {
    $('.city-group').china_city()
  }

  // 删除收货地址
  $(".address_delete_btn").on('click', function() {
    $.confirm('确定要删除此地址吗？', function(e) {
      if (e) {
        $.ajax({
          type: "DELETE",
          url: '/mall/addresses/' + $(this).data("id"),
          dataType: 'json',
          success: function(data) {
            window.location.reload();
          }
        })
      }
    }.bind(this));
  })

  // 选择收货地址
  $(".address-item").on('click', function() {
    window.location = "/mall/orders/confirm?address_id=" + $(this).data("address-id");
  })

  // 设置默认收货地址
  $(".set-default-btn").on('click', function() {
    var radioEle = $(this);
    console.log(radioEle)
    if ( radioEle.hasClass('setDef') ) {
      return;
    }
    $.ajax({
      type: "PUT",
      url: '/mall/addresses/' + radioEle.data("id") + "/make_default",
      dataType: 'json',
      beforeSend: function() {
        showFlash('#loadingToast', '数据加载中')
      },
      success: function(data) {
        window.location.reload();
      }
    })
  })
});
