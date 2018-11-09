var val = "";
<rows>
	val+="${fld:val}";
</rows>
if(val==""){
	$Dialog().confirm("选定的${fld:count}个会员将分配客服，是否继续！",function(){
		$("#select_mc").modal('show');
		//fenpei(obthis);
		
	});
}else{
	if(val.substring(0,1)=="，"){
		val = val.substring(1, val.length);
	}
	if(val.substring(val.length-1, val.length)=="，"){
		val = val.substring(0, val.length-1);
	}
	val = val.replace("，，", "，");
	val = val.substring(0, val.length);
	ccms.dialog.alert(val+"本月已分配客服！");
}

function	fenpei(customercodes){
	ccms.dialog.open({url : '${def:context}${def:actionroot}/distribution/crud?customercode='+customercodes, width:'1000',height:'600'});
}