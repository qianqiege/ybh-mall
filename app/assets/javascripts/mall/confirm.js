$(function(){

  if ( parseFloat($("#celebrate_ratsimp").data("size")) < parseFloat($("#line_item_qt").val()) ) {
    $("#celebrate_ratsimp").attr({disabled: "disabled", placeholder: "您的可用配领值不够支付该订单"});
  }

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
        celebrate_ratsimp = parseFloat($.trim($("#celebrate_ratsimp").val())) || 0, //输入的配领值数量
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
    $("#total-price").text( (total_price - real_value - money_value - celebrate_ratsimp/10).formatMoney())

  })

  $("#integral_money").on('change keyup', function() {

    var size = parseFloat($(this).data("size")),
        value = parseFloat($.trim($(this).val())),
        money_value = parseFloat($.trim($("#integral_available").val())) || 0,
        celebrate_ratsimp = parseFloat($.trim($("#celebrate_ratsimp").val())) || 0, //输入的配领值数量
        total_price = parseFloat($.trim($("#total-price").data("all_total_price")));

    if ( value < 0 || value > size ) {
      $.tips("最大可用现金为: " + size.formatMoney());
      $(this).val(size.formatMoney());
    }else {
        if ( value + money_value + celebrate_ratsimp/10 > total_price ) {
          $.tips("不能超过总计金额: " + total_price);
          $(this).val( (  total_price - money_value - celebrate_ratsimp/10).formatMoney() );
        }
    }

    real_value = parseFloat($.trim($(this).val())) || 0
      $("#total-price").text( (total_price - real_value).formatMoney() + "  元" )
      if (real_value) {
          $("#celebrate_ratsimp").attr("disabled", "disabled")
      } else {
          $("#celebrate_ratsimp").removeAttr("disabled")
      }


  })

  $("#celebrate_ratsimp").on('change keyup', function() {

    var size = parseFloat($(this).data("size")), //积分总数
        value = parseFloat($.trim($(this).val())), // 输入的积分数
        money_value = parseFloat($.trim($("#integral_money").val())) || 0, //输入的现金余额
        integral_available = parseFloat($.trim($("#integral_available").val())) || 0, //输入的易积分数量
        total_price = parseFloat($.trim($("#total-price").data("all_total_price"))), // 订单总金额
        line_item_qt = $("#line_item_qt").val(); //本次订单需用配领值；

        if( value < 0 ) {
          $.tips("您输入的值不能小于0");
        }else if ( value > line_item_qt ) {
          $(this).val(line_item_qt);
          $.tips("不能超过订单总配领值: " + line_item_qt);
        }

    // if ( value < 0 || value > line_item_qt || value > size ) {
    //   $(this).val(line_item_qt);
    //   $.tips("不能超过订单总配领值: " + line_item_qt);
    // }else {
    //     console.log(value, money_value, integral_available, total_price);
    //     if ( value/10 + money_value + integral_available > total_price ) {
    //       $.tips("不能超过总计金额: " + total_price);
    //       $(this).val( (total_price - money_value - integral_available).formatMoney()*10 );
    //     }
    //     if (value < line_item_qt) {
    //       $.tips("您需要用" + line_item_qt);
    //     }
    //     else {
    //       $("#total-price").html(0)
    //     }
    // }
    

    real_value = parseFloat($.trim($(this).val())) || 0 // 最终输入的积分数
    // $("#total-price").text( (total_price - real_value/10 - money_value - integral_available).formatMoney() )
      $("#total-price").text( ( line_item_qt - real_value  - integral_available).formatMoney() + "  配领值")
      if (real_value) {
          $("#integral_money").attr("disabled", "disabled")
      } else {
          $("#integral_money").removeAttr("disabled")
      }


  })

  $("#custom_price").on('change keyup', function() {
    custom_price = parseFloat($.trim($(this).val())),
    integral_money = parseFloat($.trim($("#integral_money").val())) || 0,
    integral_available = parseFloat($.trim($("#integral_available").val())) || 0,
    celebrate_ratsimp = parseFloat($.trim($("#celebrate_ratsimp").val())) || 0, //输入的配领值数量

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
