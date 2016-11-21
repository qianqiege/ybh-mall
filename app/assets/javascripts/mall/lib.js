// 官方默认的脚本不支持zepto，且zepto不支持gt选择器，故改写
$.fn.china_city = function() {
  return this.each(function() {
    var selects;
    selects = $(this).find('.city-select');
    return selects.change(function() {
      var $this, next_selects;
      $this = $(this);
      next_selects = selects.slice(selects.index(this) + 1);
      $(next_selects).children("option").not(function() {
        return (!!$(this).eq(0).text().match(/--.*--/))
      }).remove();
      if (next_selects.first()[0] && $this.val() && !$this.val().match(/--.*--/)) {
        return $.get("/china_city/" + ($(this).val()), function(data) {
          var i, len, option;
          if (data.data != null) {
            data = data.data;
          }
          for (i = 0, len = data.length; i < len; i++) {
            option = data[i];
            next_selects.first()[0].options.add(new Option(option[0], option[1]));
          }
          return next_selects.trigger('china_city:load_data_completed');
        });
      }
    });
  });
};
