
var yiyy = 0;var yiqx = 0;var yisk = 0;var yisy = 0;
var eryy = 0;var erqx = 0;var ersk = 0;var ersy = 0;
var sanyy = 0;var sanqx = 0;var sansk = 0;var sansy = 0;
var siyy = 0;var siqx = 0;var sisk = 0;var sisy = 0;
var wuyy = 0;var wuqx = 0;var wusk = 0;var wusy = 0;
var liuyy = 0;var liuqx = 0;var liusk = 0;var liusy = 0;
var qiyy = 0;var qiqx = 0;var qisk = 0;var qisy = 0;

$("#yinav").html("");
$("#ernav").html("");
$("#sannav").html("");
$("#sinav").html("");
$("#wunav").html("");
$("#liunav").html("");
$("#qinav").html("");

var startdate = $("#startdate").attr("code");
var ercode = $("#ercode").attr("code");
var sancode = $("#sancode").attr("code");
var sicode = $("#sicode").attr("code");
var wucode = $("#wucode").attr("code");
var liucode = $("#liucode").attr("code");
var enddate = $("#enddate").attr("code");
var count = 0;
<rows>
	//0无效、1预约中、2已上课、3爽约';
	count++;
	if(count==5)count=1;
	var _date = "${fld:c_date}";
	var starttime = "${fld:starttime}";
	starttime = starttime.substring(0,starttime.length-3);
	var endtime = "${fld:endtime}";
	endtime = endtime.substring(0,endtime.length-3);
	var strhtml = "<li class='type-"+count+"'><p><span>"+starttime+"-"+endtime+"</span> <span>${fld:vc_name@js}</span></p><p>";
	if('${fld:i_status}'=="0")strhtml+="已取消</p></li>";
	if('${fld:i_status}'=="1")strhtml+="预约中</p></li>";
	if('${fld:i_status}'=="2")strhtml+="已上课</p></li>";
	if('${fld:i_status}'=="3")strhtml+="爽约</p></li>";
	if(startdate==_date){
		if('${fld:i_status}'=="0")yiqx++;
		if('${fld:i_status}'=="1")yiyy++;
		if('${fld:i_status}'=="2")yisk++;
		if('${fld:i_status}'=="3")yisy++;
		if($("#yinav>li").length<6){
			$("#yinav").append(strhtml);
		}
	}
	if(ercode==_date){
		if('${fld:i_status}'=="0")erqx++;
		if('${fld:i_status}'=="1")eryy++;
		if('${fld:i_status}'=="2")ersk++;
		if('${fld:i_status}'=="3")ersy++;
		if($("#ernav>li").length<6){
			$("#ernav").append(strhtml);
		}
	}
	if(sancode==_date){
		if('${fld:i_status}'=="0")sanqx++;
		if('${fld:i_status}'=="1")sanyy++;
		if('${fld:i_status}'=="2")sansk++;
		if('${fld:i_status}'=="3")sansy++;
		if($("#sannav>li").length<6){
			$("#sannav").append(strhtml);
		}
	}
	if(sicode==_date){
		if('${fld:i_status}'=="0")siqx++;
		if('${fld:i_status}'=="1")siyy++;
		if('${fld:i_status}'=="2")sisk++;
		if('${fld:i_status}'=="3")sisy++;
		if($("#sinav>li").length<6){
			$("#sinav").append(strhtml);
		}
	}
	if(wucode==_date){
		if('${fld:i_status}'=="0")wuqx++;
		if('${fld:i_status}'=="1")wuyy++;
		if('${fld:i_status}'=="2")wusk++;
		if('${fld:i_status}'=="3")wusy++;
		if($("#wunav>li").length<6){
			$("#wunav").append(strhtml);
		}
	}
	if(liucode==_date){
		if('${fld:i_status}'=="0")liuqx++;
		if('${fld:i_status}'=="1")liuyy++;
		if('${fld:i_status}'=="2")liusk++;
		if('${fld:i_status}'=="3")liusy++;
		if($("#liunav>li").length<6){
			$("#liunav").append(strhtml);
		}
	}
	if(enddate==_date){
		if('${fld:i_status}'=="0")qiqx++;
		if('${fld:i_status}'=="1")qiyy++;
		if('${fld:i_status}'=="2")qisk++;
		if('${fld:i_status}'=="3")qisy++;
		if($("#qinav>li").length<6){
			$("#qinav").append(strhtml);
		}
	}
</rows>
$("#yizong").html(yiqx+yiyy+yisk+yisy);
$("#yiqx").html(yiqx);$("#yiyy").html(yiyy);
$("#yisk").html(yisk);$("#yisy").html(yisy);

$("#erzong").html(erqx+eryy+ersk+ersy);
$("#erqx").html(erqx);$("#eryy").html(eryy);
$("#ersk").html(ersk);$("#ersy").html(ersy);

$("#sanzong").html(sanqx+sanyy+sansk+sansy);
$("#sanqx").html(sanqx);$("#sanyy").html(sanyy);
$("#sansk").html(sansk);$("#sansy").html(sansy);

$("#sizong").html(siqx+siyy+sisk+sisy);
$("#siqx").html(siqx);$("#siyy").html(siyy);
$("#sisk").html(sisk);$("#sisy").html(sisy);

$("#wuzong").html(wuqx+wuyy+wusk+wusy);
$("#wuqx").html(wuqx);$("#wuyy").html(wuyy);
$("#wusk").html(wusk);$("#wusy").html(wusy);

$("#liuzong").html(liuqx+liuyy+liusk+liusy);
$("#liuqx").html(liuqx);$("#liuyy").html(liuyy);
$("#liusk").html(liusk);$("#liusy").html(liusy);

$("#qizong").html(qiqx+qiyy+qisk+qisy);
$("#qiqx").html(qiqx);$("#qiyy").html(qiyy);
$("#qisk").html(qisk);$("#qisy").html(qisy);

var gengduohtml = "<li onclick='morelist(this)' class='type-1'><p>更多</p></li>";
if($("#yinav>li").length>5){
	$("#yinav").append(gengduohtml);
}
if($("#ernav>li").length>5){
	$("#ernav").append(gengduohtml);
}
if($("#sannav>li").length>5){
	$("#sannav").append(gengduohtml);
}
if($("#sinav>li").length>5){
	$("#sinav").append(gengduohtml);
}
if($("#wunav>li").length>5){
	$("#wunav").append(gengduohtml);
}
if($("#liunav>li").length>5){
	$("#liunav").append(gengduohtml);
}
if($("#qinav>li").length>5){
	$("#qinav").append(gengduohtml);
}

