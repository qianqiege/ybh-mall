$(function () {
  $("#create_address_btn").on('click', function() {
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

  if ( $('.city-group').length > 0 ) {
    $('.city-group').china_city()
  }

  $(".address_delete_btn").on('click', function() {
    $.confirm('确定要删除此商品吗？', function(e) {
      $.ajax({
        type: "DELETE",
        url: '/mall/addresses/' + $(this).data("id"),
        dataType: 'json',
        success: function(data) {
          window.location.reload();
        }
      })
    }.bind(this));
  })

  $(".set-default-btn").on('click', function() {
    if ( $(this).hasClass('setDef') ) {
      return;
    }
    $.ajax({
      type: "PUT",
      url: '/mall/addresses/' + $(this).data("id") + "/make_default",
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
