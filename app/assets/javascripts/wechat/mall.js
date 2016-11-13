$(function () {
  var $searchBar = $('#searchBar'),
  $searchResult = $('#searchResult'),
  $searchText = $('#searchText'),
  $searchInput = $('#searchInput'),
  $searchClear = $('#searchClear'),
  $searchCancel = $('#searchCancel');

  function hideSearchResult(){
    $searchResult.hide();
    $searchInput.val('');
  }
  function cancelSearch(){
    hideSearchResult();
    $searchBar.removeClass('weui-search-bar_focusing');
    $searchText.show();
  }

  $searchText.on('click', function(){
    $searchBar.addClass('weui-search-bar_focusing');
    $searchInput.focus();
  });
  $searchInput
  .on('blur', function () {
    if(!this.value.length) cancelSearch();
  })
  .on('input', function(){
    if(this.value.length) {
      $searchResult.show();
    } else {
      $searchResult.hide();
    }
  })
  ;
  $searchClear.on('click', function(){
    hideSearchResult();
    $searchInput.focus();
  });
  $searchCancel.on('click', function(){
    cancelSearch();
    $searchInput.blur();
  });

  var $buyNum = $("#buyNum"),
      $maxNum = parseInt($("#shop_count").text());
  $("#increase_btn").on('click', function() {
    if ($maxNum === parseInt($buyNum.val())) {
      return;
    }
    $buyNum.val(parseInt($buyNum.val()) + 1)
  })

  $("#decrease_btn").on('click', function() {
    if (1 === parseInt($buyNum.val())) {
      return;
    }
    $buyNum.val(parseInt($buyNum.val()) - 1)
  })

});
