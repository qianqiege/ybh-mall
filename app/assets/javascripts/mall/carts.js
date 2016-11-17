$(function () {
  $(".increase_btn_ajax").on('click', function() {
    $(this).shop_count_increase_control();
  })

  $(".decrease_btn_ajax").on('click', function() {
    $(this).shop_count_decrease_control();
  })

  $(".del").on('click', function() {
    var line_item_id = $(this).data("line_item_id"),
        total_price = $("#total-price").text();
        url = "/mall/line_items/" + line_item_id;
    line_item_add_and_remove(url, line_item_id, total_price, "DELETE", $(this));
    $(this).parent().parent().remove();
  })

  $("#clearing_commit").on('click', function() {
    event.preventDefault();
    $("#show_cart").submit();
  })
});
