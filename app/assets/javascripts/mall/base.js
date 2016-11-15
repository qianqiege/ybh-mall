(function() {
  // 验证手机号码
  this.validateMobile = function (text) {
    return !!/^(13[0-9]|15[012356789]|17[0123456789]|18[0-9]|14[57])[0-9]{8}$/.test(text);
  }

  // 验证短信验证码
  this.validateCode = function (text) {
    return !!/[0-9]{6}/.test(text);
  }

  // 显示flash框
  // 调用方法 showFlash(div_id, text)
  // div_id 可为 toast-success(成功提示框) loadingToast(正在加载中提示框) toast-custom(没有图示的提示框)
  // text为提示文字
  // example: showFlash('#toast-success', '已加入购物车');
  this.showFlash = function (div_id, text) {
    var $toast = $(div_id),
        $successText = $toast.find('.weui-toast__content');

    if (!$toast.hasClass('hide')) return;

    $toast.removeClass('hide');
    $successText.text(text);

    setTimeout(function () {
      $toast.addClass('hide');
      $successText.text("");
    }, 2000);
  }

  // Make Zepto XHR play nicely with Rails XSS protection
  $.ajaxSettings.headers || ($.ajaxSettings.headers = {});
  $.ajaxSettings.headers['X-CSRF-TOKEN'] = $("meta[name='csrf-token']").attr('content');
}).call(this);
