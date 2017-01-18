(function() {
  // 验证手机号码
  this.validateMobile = function (text) {
    return !!/^(13[0-9]|15[012356789]|17[0123456789]|18[0-9]|14[57])[0-9]{8}$/.test(text);
  }

  // 验证短信验证码
  this.validateCode = function (text) {
    return !!/[0-9]{6}/.test(text);
  }

  // 验证身份证号码
  this.validateIdentityCard = function (text) {
    return !!/^([0-9]){7,18}(x|X)?$/.test(text);
  }

  // 验证密码 字母开头，长度在6~18之间，只能包含字母、数字和下划线
  this.validatePassword = function (text) {
    return !!/^[a-zA-Z]\w{5,17}$/.test(text);
  }

  // 格式化金额
  Number.prototype.formatMoney = function(c, d, t){
    var n = this,
      c = isNaN(c = Math.abs(c)) ? 2 : c,
      d = d == undefined ? "." : d,
      t = t == undefined ? "" : t,
      s = n < 0 ? "-" : "",
      i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))),
      j = (j = i.length) > 3 ? j % 3 : 0;
    return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
  };

  // 显示flash框
  // 调用方法 showFlash(div_id, text)
  // div_id 可为 toast-success(成功提示框) loadingToast(正在加载中提示框) toast-custom(没有图示的提示框)
  // text为提示文字
  // example: showFlash('#toast-success', '已加入购物车');
  this.showFlash = function (div_id, text) {
    var $toast = $(div_id),
        $successText = $toast.find('.weui-toast__content');

    if (!$toast.hasClass('hide')) return;

    $toast.fadeIn();
    $successText.text(text);

    setTimeout(function () {
      $toast.fadeOut();
    }, 1000);
  }

  // Make Zepto XHR play nicely with Rails XSS protection
  $.ajaxSettings.headers || ($.ajaxSettings.headers = {});
  $.ajaxSettings.headers['X-CSRF-TOKEN'] = $("meta[name='csrf-token']").attr('content');
}).call(this);

$(function () {
  if ( $(".notice").length > 0 ) {
    $(".notice").fadeOut(5000);
  }

  $(document).on('ajaxError', function(e, xhr, options){
    showFlash('#toast-custom', '发生错误了')
  })
});
