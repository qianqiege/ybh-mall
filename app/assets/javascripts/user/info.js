$(function () {
  $("#submit-wallet").on('click', function() {
    var username = $("#wallet-username").val();
    var password = $("#wallet-password").val();
    $.ajax({
      type: 'POST',
      url: '/user/do_query_wallet',
      data: {username: username, password: password},
      dataType: 'json',
      beforeSend: function() {
        showFlash('#loadingToast', '正在登录中...')
      },
      success: function(data) {
        if (data.status == 'ok') {
          showFlash("#toast-custom", '登录成功');
          window.location.href = "/user/query_wallet?username=" + username + "&password=" + password;
        } else {
          $.tips(data.message);
        }
      },
      error: function() {
        $.tips('出错了');
      }
    })
  })

  $(".showtoast").click(function(){
    $('#dialog1').attr("style","");
  })

});
