$(function(){
  $('#reservation_record_work_id, #reservation_record_rank_id').on('change', function(){
    var work_id = $('#reservation_record_work_id').val();
    var rank_id = $('#reservation_record_rank_id').val();
    if(work_id && rank_id){
      var url = '/service_spinebuild/reservation/show_spine';
      var params = {work_id: work_id, rank_id: rank_id};
      $.get(url, params, function(data){
        if(data.length){
          var $selects = $("#reservation_record_spine_build_id");
          for (i = 0, len = data.length; i < len; i++) {
            option = data[i];
            $selects[0].options.add(new Option(option.name, option.id));
          }

        }else{
          $("#reservation_record_spine_build_id").html(new Option('请选择', '0'));
          showFlash('#toast-warn', '没有对应筑脊师, 请重新选择');
        }
      });
    }
  })
})
