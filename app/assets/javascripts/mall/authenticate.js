$(function () {
  $("#smsgetCode").on('click', function(event) {
    event.preventDefault();

    // 默认为1分钟
    var time = 1 * 60,
        mobile = $.trim($("#txtCustomerID").val()).replace(/\s/g, ""),
        $smsTimeText = $("#smsTimeText"),
        $toast = $("#toast-custom");

    if (!validateMobile(mobile)) {
      showFlash("#toast-custom", '无效的手机号码');

      return;
    }

    $smsTimeText.text(time);
    $("#smsgetCode").addClass('hide');
    $("#resetText").removeClass('hide');

    $.get("/sms_code?mobile=" + mobile);

    var int = self.setInterval(function() {
      $smsTimeText.text( parseInt($smsTimeText.text()) - 1 );
    }.bind(this), 1000)

    setTimeout(function() {
      window.clearInterval(int);
      $(this).text('发送验证码');
      $("#smsgetCode").removeClass('hide');
      $("#resetText").addClass('hide');
    }.bind(this), time * 1000)
  });
});
