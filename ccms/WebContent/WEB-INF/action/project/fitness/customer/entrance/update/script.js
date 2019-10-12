
var count = 0;
var type="";
<rows>
	count++;
	type = "${fld:type}";
</rows>
var instr = "in", outstr = "out";
if($("#inlefttype").val()=="1"){
	instr = "in";
	outstr = "out";
}else if($("#inlefttype").val()=="2"){
	instr = "expercardin";
	outstr = "expercardout";
}
//count==0说明没有入场记录，当前是入场操作
if(count==0){
	var url="${def:context}${def:actionroot}/"+instr;
	posturl(url);
}else{
	//type等于空字符串或者2说明应该入场
	if(type==""||type=="2"){
		var url="${def:context}${def:actionroot}/"+instr;
		posturl(url);
	}else{
		var url="${def:context}${def:actionroot}/"+outstr;
		posturl(url);
	}
}

function posturl(url){
	ajaxCall(url,{
		method:"post",
		form:"searchForm",
		progress:true,
		dataType:"script",
		success:function(){
		}
	});
}
