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

    var size = parseFloat($(this).data("size")), //积分总数
        value = parseFloat($.trim($(this).val())), // 输入的积分数
        money_value = parseFloat($.trim($("#integral_money").val())) || 0, //输入的现金余额
        celebrate_ratsimp = parseFloat($.trim($("#celebrate_ratsimp").val())) || 0, //输入的庆通分数量
        total_price = parseFloat($.trim($("#total-price").data("all_total_price")));  // 订单总金额

    if ( value < 0 || value > size ) {
      $.tips("最大可用积分为: " + size.formatMoney());
      $(this).val(size.formatMoney());
    }else {
      if ( value + money_value + celebrate_ratsimp/10 > total_price ) {
        $.tips("不能超过总计金额: " + total_price);
        $(this).val( (total_price - money_value -celebrate_ratsimp/10).formatMoney() );
      }

    }



    real_value = parseFloat($.trim($(this).val())) || 0 // 最终输入的积分数
    $("#total-price").text( (total_price - real_value*2 - money_value - celebrate_ratsimp/10).formatMoney() )

  })

  // $("#integral_money").on('change keyup', function() {

  //   var size = parseFloat($(this).data("size")),
  //       value = parseFloat($.trim($(this).val())),
  //       money_value = parseFloat($.trim($("#integral_available").val())) || 0,
  //       celebrate_ratsimp = parseFloat($.trim($("#celebrate_ratsimp").val())) || 0, //输入的庆通分数量
  //       total_price = parseFloat($.trim($("#total-price").data("all_total_price")));

  //   if ( value < 0 || value > size ) {
  //     $.tips("最大可用现金为: " + size.formatMoney());
  //     $(this).val(size.formatMoney());
  //   }else {
  //       if ( value + money_value + celebrate_ratsimp/10 > total_price ) {
  //         $.tips("不能超过总计金额: " + total_price);
  //         $(this).val( (  total_price - money_value - celebrate_ratsimp/10).formatMoney() );
  //       }
  //   }



  //   real_value = parseFloat($.trim($(this).val())) || 0
  //   $("#total-price").text( (total_price - real_value - money_value - celebrate_ratsimp/10).formatMoney() )

  // })

  $("#celebrate_ratsimp").on('change keyup', function() {

    var size = parseFloat($(this).data("size")), //积分总数
        value = parseFloat($.trim($(this).val())), // 输入的积分数
        // money_value = parseFloat($.trim($("#integral_money").val())) || 0, //输入的现金余额
        // integral_available = parseFloat($.trim($("#integral_available").val())) || 0, //输入的易积分数量
        total_price = parseFloat($.trim($("#total-price").data("all_total_price"))), // 订单总金额
        line_item_qt = $("#line_item_qt").val();


    if ( value < 0 || value > size ) {
      $.tips("最大可用庆通分为: " + size.formatMoney());
      $(this).val(size.formatMoney());
    } else {
        // if ( value/10 + money_value + integral_available > total_price ) {
        //   $.tips("不能超过总计金额: " + total_price);
        //   $(this).val( (total_price - money_value - integral_available).formatMoney()*10 );
        // }
        if (value < line_item_qt) {
          $.tips("您需要用" + line_item_qt);
        }
        else {
          $("#total-price").html(0)
        }
    }

    real_value = parseFloat($.trim($(this).val())) || 0 // 最终输入的积分数
    $("#total-price").text( (total_price - real_value/10 - money_value - integral_available).formatMoney() )

  })

  $("#custom_price").on('change keyup', function() {
    custom_price = parseFloat($.trim($(this).val())),
    integral_money = parseFloat($.trim($("#integral_money").val())) || 0,
    integral_available = parseFloat($.trim($("#integral_available").val())) || 0,
    celebrate_ratsimp = parseFloat($.trim($("#celebrate_ratsimp").val())) || 0, //输入的庆通分数量

    real_value = custom_price - integral_money - integral_available - celebrate_ratsimp/10;
    $("#total-price").data("all_total_price", custom_price);
    if(real_value < 0) {
      $.tips("不能自定义价格: " + custom_price.formatMoney());
      $("#integral_money").val(0);
      $("#integral_available").val(0);
    } else {
      $("#total-price").text((real_value).formatMoney());
    }
  })


  var values = $(".weui-cell__bd #activity_id option").value;
  if (values == 1) {
    $("#scoin_account").show()
  }else {
    $("#scoin_account").hide()
  }

})
