$(function(){
  $("#activity_id").on('change', function(event){
    if(event.currentTarget.value){
      $("#scoin_account").show();
    }else{
      $("#scoin_account").hide();
    }
  });
})
