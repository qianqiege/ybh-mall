$(function(){
  $("#activity_id").on('change', function(event){
    var id = event.currentTarget.value
    if(id){
      $.ajax({
        type: "GET",
        url: '/mall/activity/' + id + "/scoin_type_count",
        dataType: 'json',
        beforeSend: function() {
          showFlash('#loadingToast', '数据加载中')
        },
        success: function(data) {
          if(data.result == "ok"){
            $("#scoin_account").show();
          } else {
            $("#scoin_account").hide();
          }
        }
      })
    }else{
      $("#scoin_account").hide();
    }
  });

  $("#integral_available").on('change keyup', function() {

    var size = parseFloat($(this).data("size"));
        value = parseFloat($.trim($(this).val())),
        money_value = parseFloat($.trim($("#integral_money").val())) || 0,
        total_price = parseFloat($.trim($("#total-price").data("all_total_price")));

    if ( value < 0 || value > size ) {
      $.tips("最大可用积分为: " + size.formatMoney());
      $(this).val(size.formatMoney());
    }

    if ( value + money_value > total_price ) {
      $.tips("不能超过总计金额: " + total_price);
      $(this).val( (total_price - money_value).formatMoney() );
    }

    real_value = parseFloat($.trim($(this).val())) || 0
    $("#total-price").text( (total_price - real_value - money_value).formatMoney() )

  })

  $("#integral_money").on('change keyup', function() {

    var size = parseFloat($(this).data("size")),
        value = parseFloat($.trim($(this).val())),
        money_value = parseFloat($.trim($("#integral_available").val())) || 0,
        total_price = parseFloat($.trim($("#total-price").data("all_total_price")));

    if ( value < 0 || value > size ) {
      $.tips("最大可用现金为: " + size.formatMoney());
      $(this).val(size.formatMoney());
    }

    if ( value + money_value > total_price ) {
      $.tips("不能超过总计金额: " + total_price);
      $(this).val( (total_price - money_value).formatMoney() );
    }

    real_value = parseFloat($.trim($(this).val())) || 0
    $("#total-price").text( (total_price - real_value - money_value).formatMoney() )

  })

  $("#custom_price").on('change keyup', function() {
      value = parseFloat($.trim($(this).val())),
      total_price = parseFloat($.trim($("#total-price").data("all_total_price")));
      $("#total-price").text( (value ).formatMoney() )
  })

})
