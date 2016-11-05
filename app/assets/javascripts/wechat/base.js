$(function(){
  $('body').on('touchmove', function (event) {
    event.preventDefault();
  });

  $('.weui-tab__panel').on('touchmove',function(e){
    e.stopPropagation();
  })
});
