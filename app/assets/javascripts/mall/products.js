$(function () {
  var $buyNum = $("#buyNum"),
      $maxNum = parseInt($("#shop_count").text());

  $("#increase_btn").on('click', function() {
    if ($maxNum === parseInt($buyNum.val())) {
      return;
    }
    $buyNum.val(parseInt($buyNum.val()) + 1)
  });

  $("#decrease_btn").on('click', function() {
    if (1 === parseInt($buyNum.val())) {
      return;
    }
    $buyNum.val(parseInt($buyNum.val()) - 1)
  });
});
