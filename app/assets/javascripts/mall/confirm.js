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

    var size = $(this).data("size");
    var value = $.trim($(this).val());

    if ( value < 0 || value > size ) {
      $.tips("最大可用积分为: " + size);
      $(this).val(size);
    }

  })

  $("#integral_money").on('change keyup', function() {

    var size = $(this).data("size");
    var value = $.trim($(this).val());

    if ( value < 0 || value > size ) {
      $.tips("最大可用现金为: " + size);
      $(this).val(size);
    }

  })
})
