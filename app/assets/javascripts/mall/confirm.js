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
          if(data.scoin_type_count >= 1){
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
})
