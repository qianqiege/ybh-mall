$(function () {
  $("#create_address_btn").on('click', function() {
    event.preventDefault();

    if ($("#new_address").length > 0) {
      $("#new_address").submit();
      return;
    }

    if ($(".edit_address").length > 0) {
      $(".edit_address").submit();
      return;
    }
  })

  $('.city-group').china_city()

  $(".address_delete_btn").on('click', function() {
    $.ajax({
      type: "DELETE",
      url: '/mall/addresses/' + $(this).data("id"),
      dataType: 'json',
      success: function(data) {
        window.location.reload();
      },
      error: function(xhr, type){
        showFlash('#toast-custom', '发生错误了')
      }
    })
  })
});
