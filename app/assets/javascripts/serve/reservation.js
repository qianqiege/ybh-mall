$(function() {


    $("input[id^='sHour_']").parents(".weui-cell").hide();
    var sTime=(new Date().getHours()>=18?1:0)*86400000+new Date().getTime()-86400000,d=0;
    while (d<7) {
        sTime+=86400000;
        var tmpTime=new Date(sTime);
        if (tmpTime.getDay()===0 || tmpTime.getDay()===6) {
            continue;
        }
        $("#oDate").append($('<label class="weui-cell weui-check__label" for="oDate_'+tmpTime.Format("yyyy-MM-dd")+'"><div class="weui-cell__bd"><p>'+tmpTime.Format("yyyy-MM-dd")+'</p></div><div class="weui-cell__ft"><input type="radio" class="weui-check" name="oDate" id="oDate_'+tmpTime.Format("yyyy-MM-dd")+'" value="'+tmpTime.Format("yyyy-MM-dd")+'"><span class="weui-icon-checked"></span></div></label>'));
        d++;
    }

    $("input[name='oDate']").change(function() {
        $("#orderSubmitButton").attr("disabled","disabled").addClass("weui-btn_disabled");
        $("input[id^='sHour_']").parents(".weui-cell").hide();
        $("input[name='sHour']:checked").removeAttr("checked");
        doAjax(location.href,"post",{"date":$("input[name='oDate']:checked").val()},orderCb1,1,orderCb1,0);
    });

    $("input[name='sHour']").change(function() {
        if ($(this).find("span").html()!=="&nbsp;剩余 0 个名额") {
            $("#orderSubmitButton").removeAttr("disabled").removeClass("weui-btn_disabled");
        } else {
            $("#orderSubmitButton").attr("disabled","disabled").addClass("weui-btn_disabled");
        }
    });

    var orderCb1=function(data,status) {
        var errmsg={
            "-1": "您已预约过本项服务",
            "-2": "预约日期无效，请检查手机日期设置",
            "-3": "日期格式错误",
            "-4": "预约时段无效，请检查手机日期设置",
            "-5": "您只能在近七个工作日内进行预约，请检查手机日期设置",
            "-6": "预约名额超限"
        };
        if (status) {
            if (data["errno"]) {
                showTooltips(errmsg[data["errno"]]);
            } else {
                var remainingNumber={12:5,13:5,14:5,16:5,17:5,18:5};
                for (var i=0;i<data["data"].length;i++) {
                    remainingNumber[data["data"][i]["startHour"]]=5-~~data["data"][i]["c"]; //~~ 强制转换类型
                }
                for (var i in remainingNumber) {
                    $("#num_"+i).html("&nbsp;剩余 "+remainingNumber[i]+" 个名额");
                }
                var nowTime=~~new Date().Format("h");
                if (new Date().Format("yyyy-MM-dd")===$("input[name='oDate']:checked").val()) {
                    $("input[id^='sHour_']").each(function() {
                        if (~~$(this).attr("id").match(/^sHour_(\d{2})$/)[1]>nowTime) {
                            $(this).parents(".weui-cell").show();
                        }
                    });
                } else {
                    $("input[id^='sHour_']").parents(".weui-cell").show();
                }
                $('.weui-tab__panel').animate({scrollTop:$(".weui-tab__panel").height()}, "fast");
                if ($("input[name='sHour']:checked").length && $("input[name='sHour']:checked").parents("weui-cell").find("span[id^='num_']")!=="&nbsp;剩余 0 个名额") {
                    $("#orderSubmitButton").removeAttr("disabled").removeClass("weui-btn_disabled");
                } else {
                    $("#orderSubmitButton").attr("disabled","disabled").addClass("weui-btn_disabled");
                }
            }
        } else {
            showTooltips("网络错误");
        }
    };

    $("#orderSubmitButton").click(function() {
        $("#dialogTime").html($("input[name='oDate']:checked").val()+"&nbsp;"+$("input[name='sHour']:checked").val()+":00-"+(~~$("input[name='sHour']:checked").val()+1)+":00");
        $("#confirmDialog").fadeIn(200);
    });

    var confirmAjaxRunning=0;
    $("#confirmDialog .weui-dialog__btn_primary").click(function() {
        if (confirmAjaxRunning) {
            return false;
        }
        confirmAjaxRunning=1;
        $("#loadingToast").show();
        doAjax(location.href,"post",{"date":$("input[name='oDate']:checked").val(),"startHour":$("input[name='sHour']:checked").val()},orderCb2,1,orderCb2,0);
    });

    var orderCb2=function(data,status) {
        confirmAjaxRunning=0;
        $("#loadingToast").hide();
        var errmsg={
            "-1": "您已预约过本项服务",
            "-2": "预约日期无效，请检查手机日期设置",
            "-3": "日期格式错误",
            "-4": "预约时段无效，请检查手机日期设置",
            "-5": "您只能在近七个工作日内进行预约，请检查手机日期设置",
            "-6": "预约名额超限"
        };
        if (status) {
            if (data["errno"]) {
                showTooltips(errmsg[data["errno"]]);
            } else {
                $("#successToast").show();
                setTimeout(function () {
                    $("#successToast").hide();
                    location.href="{{ env('APP_URL') }}my";
                }, 2000);
            }
        } else {
            showTooltips("网络错误");
        }
    };
});
