#= require active_admin/base
#= require activeadmin_addons/all

$(function () {
    // if（$("#supplier_order_is_amended").val() == 0){
    //     console
    // }else{
    //
    $('#supplier_order_order_date_input').hide();
    $("#supplier_order_is_amended").click(function () {
        if ($("#supplier_order_is_amended").prop("checked")) {
            $('#supplier_order_order_date_input').show();
        } else {
            $('#supplier_order_order_date_input').hide();
        }
    })
});