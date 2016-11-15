(function() {
  this.validateMobile = function (text) {
    var trim_text = $.trim(text + "").replace(/\s/g, "");
    return !!/^(13[0-9]|15[012356789]|17[0123456789]|18[0-9]|14[57])[0-9]{8}$/.test(trim_text)
  }
}).call(this);
