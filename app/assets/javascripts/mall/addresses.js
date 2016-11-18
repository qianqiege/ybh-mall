$(function () {
  $("#create_address_btn").on('click', function() {
    event.preventDefault();
    $("#new_address").submit();
  })
  $('.city-group').china_city()
});
