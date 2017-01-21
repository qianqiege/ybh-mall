$(function () {
  $(".remove_binding_wechat_user_btn").on('click', function(event) {
    event.preventDefault();
    $.confirm('确定要解除绑定此微信账号吗？', function(e) {
      var id = $(this).data('id');
      if (e) {
        $.ajax({
          type: 'POST',
          url: '/mall/my/unbinding_wechat_user/' + id,
          data: {},
          dataType: 'json',
          success: function(data) {
            showFlash("#toast-custom", '解绑成功');
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
