
var day = new Date().getDay();
var rowscount = 0, count=0, str = "", wcount = 0;
<rows>
	rowscount++;
	/*if(("${fld:weekday}"==""&&"${fld:num}"=="1")||("${fld:weekday}"==day&&"${fld:num}"=="1")){
		count++;
	}*/
	if(("${fld:weekday}"==""&&${fld:datetime}>=${fld:starttime}&&${fld:datetime}<=${fld:endtime})
			||("${fld:weekday}"==day&&${fld:datetime}>=${fld:starttime}&&${fld:datetime}<=${fld:endtime})){
		count++;
	}else{
		if("${fld:weekday}"==""){
			str+="任意日期${fld:starttime1}~${fld:endtime1}";
		}else{
			var weekDay = ["周日", "周一", "周二", "周三", "周四", "周五", "周六"];
			str+=weekDay["${fld:weekday}"]+"${fld:starttime1}~${fld:endtime1}&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		wcount++;
		if(wcount%2==0){
			str+="<br/>";
		}
	}
</rows>
//rowscount等于0，则说明该卡没有时间段限制
if(rowscount==0){
	$("#cardtypetimelimit").val(1);
}else{
	$("#cardtypetimelimit").val(count);
	$("#cardtypetimelimitstr").val(str);
}