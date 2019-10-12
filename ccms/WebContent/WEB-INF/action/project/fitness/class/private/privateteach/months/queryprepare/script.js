$(".plist").empty();
$(".plist").attr('code','0');
var a=0
///0无效、1预约中、2已上课 3爽约


$("#calendar .pull-right").each(function(){
	$(this).after('<div class="plist" code1="0" code2="0" code3="0" code4="0" code="0" style="overflow:hidden;"></div>');
})

<rows>
	var numone = 0;
	var numtwo = 0;
	var numthree = 0;
	var numfour = 0;
a++;
	var _date = "${fld:c_date}";
	var pobj = $("span[data-cal-date=" + _date + "]").parent().find(".plist");
	if( undefined == pobj || null == pobj || 0 == pobj.length ){
		pobj = $("span[data-cal-date=" + _date + "]").parent().find(".plist");
	}
	var num = pobj.attr("code");
	if( isNumber(num) && parseInt(num) >=0 ){
		num = parseInt(num);
	}else{
		num = 0;
	}
	/*if(num<2){
		pobj.append("<br/><span style='color:blue'>${fld:c_date} ${fld:vc_name@js}</span>");
	}*/
	if('${fld:i_status}'=="0")
		numone++;
	if('${fld:i_status}'=="1")
		numtwo++;
	if('${fld:i_status}'=="2")
		numthree++;
	if('${fld:i_status}'=="3")
		numfour++;
	num++;
	pobj.attr("code1",numone+parseInt(pobj.attr("code1")));
	pobj.attr("code2",numtwo+parseInt(pobj.attr("code2")));
	pobj.attr("code3",numthree+parseInt(pobj.attr("code3")));
	pobj.attr("code4",numfour+parseInt(pobj.attr("code4")));
</rows>
if(a==0){
	$(".plist").empty();
	$(".plist").attr('code','0');
}
	$(".plist").each(function(){
		/*$(this).append("<br/>(共"+(parseInt($(this).attr("code1"))+parseInt($(this).attr("code2"))+parseInt($(this).attr("code3"))
				+parseInt($(this).attr("code4")))+"人)");*/
			var num=0;
			num=  parseInt($(this).attr("code1"))+
						parseInt($(this).attr("code2"))+
						parseInt($(this).attr("code3"))+
						parseInt($(this).attr("code4"));

		if( $(this).parent().find('div[code=total]').length == 0 ){
			$(this).parent().append('<div code="total"></div>');
		}
		$(this).parent().find('div[code=total]').empty();
		if(num>0){
			$(this).parent().find('div[code=total]').append('<p>共计:<span>'+num+'</span>人</p>');
		}
					
		$(this).append("<nav>");
		$(this).append("<li>预约中:<span>"+$(this).attr("code2")+"</span>人</li>");
		$(this).append("<li>已上课:<span>"+$(this).attr("code3")+"</span>人</li>");
		$(this).append("<li>已取消:<span>"+$(this).attr("code1")+"</span>人</li>");
		$(this).append("<li>爽约:<span>"+$(this).attr("code4")+"</span>人</li>");
		$(this).append("</nav>");
		
	})
$(".cal-cell1 .cal-month-day span").each(function(){
	if($(this).attr('data-cal-date')<(new Date()).format('yyyy-MM-dd')){
		$(this).parent().addClass("passed");
	}
});

