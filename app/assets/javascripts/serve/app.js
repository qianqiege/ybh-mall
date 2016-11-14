var doAjax=function(ajaxUrl,ajaxType,ajaxData,callbackFunc,callbackFuncArgus,errFunc,errFuncFuncArgus) {
    jQuery.ajax({
        type: ajaxType,
        url: ajaxUrl,
        dataType: 'json',
        timeout: 5000,
        data: ajaxData,
        success: function(re) {
            callbackFunc(re,callbackFuncArgus);
        },
        error: function(XMLHttpRequest,status) {
            errFunc(status,errFuncFuncArgus,{"type":ajaxType,"url":ajaxUrl,"data":ajaxData});
        }
    });
};

Date.prototype.Format = function(fmt) {
    var o = {
        "M+" : this.getMonth()+1,
        "d+" : this.getDate(),
        "h+" : this.getHours(),
        "m+" : this.getMinutes(),
        "s+" : this.getSeconds(),
        "q+" : Math.floor((this.getMonth()+3)/3),
        "S"  : this.getMilliseconds()
    };
    if(/(y+)/.test(fmt))
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
    for(var k in o)
        if(new RegExp("("+ k +")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
    return fmt;
};

var showTooltips=function(msg) {
    var e=arguments[1]||null;

    if (e) {
        $(e).parent().parent().addClass("weui-cell_warn");
        if (!$(e).parent().parent().find(".weui-cell__ft").length) {
            $(e).parent().parent().append($('<div class="weui-cell__ft"><i class="weui-icon-warn"></i></div>'));
        }
    }

    var $tooltips = $('.js_tooltips');

    $tooltips.html(msg);

    if ($tooltips.css('display') != 'none') return;

    // toptips的fixed, 如果有`animation`, `position: fixed`不生效
    $('.page.cell').removeClass('slideIn');

    $tooltips.css('display', 'block');
    setTimeout(function () {
        $tooltips.css('display', 'none');
    }, 2000);
};

//Profile 段 JS 待分离

var profileCb=function(data,status) {
    $("#loadingToast").hide();
    if (status) {
        if (data["errno"]) {
            showTooltips("请检查您输入的内容",$("#"+data["errField"]));
        } else {
            $("#successMsg").show();
            $("#profileForm").hide();
        }
    } else {
        showTooltips("网络错误");
    }
};

var submitProfile=function() {
    try {
        $("#profileForm input").each(function() {
            if (!$(this).val()) {
                throw this;
            }
        });
        $("#loadingToast").show();
        doAjax(location.href,"post",$("#profileForm").serialize(),profileCb,1,profileCb,0);
    } catch (e) {
        showTooltips("请检查您输入的内容",e);
        return false;
    }
};

$("#profileForm").on('input propertychange','input', function() {
    $(this).parent().parent().removeClass("weui-cell_warn");
    $(this).parent().parent().find(".cell__ft").remove();
});

//Profile 段 JS 结束

//tabbar 段 JS

$(".weui-tabbar a").each(function() {
    if (location.pathname==$(this).attr("href")) {
        $(this).addClass("weui-bar__item_on");
    }
});
