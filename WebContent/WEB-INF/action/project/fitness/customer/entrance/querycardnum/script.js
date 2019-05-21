$("#checkedcard").val("");
var count = 0;
var cardcode = "", customercode = '', unionorgid = "", status="", statusname="", statustype = "";
$("#unionorgid").val("");
<rows>
	count++;
	cardcode = "${fld:code}";
	customercode = "${fld:customercode}";
	unionorgid = "${fld:unionorgid}";
	$("#unionorgid").val(unionorgid);
	statusname = "${fld:statusname}";
	status = "${fld:status}";
	statustype = "${fld:statustype}";
</rows>
//判断如果是一条数据将卡号放到页面   查询出的所有卡默认选中当前卡
if(count==1){
	$("#checkedcard").val(cardcode);
	if(status!="1"){
		ccms.dialog.notice("该卡状态为"+statusname, 3000, function(){
			//过期清空
			if(status==6){
				$("#clearform").click();
				return;
			}
		});
	}
}
//当前查询到1条记录以上则根据条件再次查找所有的记录
if(count==1){
	//statustype等于2说明是二维码刷卡   /** ${fld:custallcardvalue}入场是否查询会员所有卡  后台设置入场规则有设置  **/
	if(statustype=="2"||"${fld:custallcardvalue}"=="0"){
		var url="${def:context}${def:actionroot}/searchcard?custall="+customercode+"&cardcode="+cardcode+"&unionorgid="
			+unionorgid+"&checkedcard="+cardcode;
		ajaxCall(url,{
			method:"GET",
			progress:true,
			dataType:"script",
			success:function(){
			}
		});
		var classdefurl="${def:context}${def:actionroot}/searchclassprepare?custall="+customercode+"&unionorgid="+unionorgid;
		search(classdefurl);
		$("#searchhtml").show();
	}else{
		//进入说明当前刷卡不是二维码刷卡并且后台设置查询多卡
		//$("#unionorgid").val("${def:org}");
		ccms.dialog.open({url : "${def:context}/action/project/fitness/util/querycustcardocdelistinout/crud?pickcustname="
				+"${fld:custall}&objid=cust_code&objidtwo=custall&unionorgid=unionorgid&random_number="+Math.random(), id:"rc1001", height:650});
	}
}else{
	ccms.dialog.open({url : "${def:context}/action/project/fitness/util/querycustcardocdelistinout/crud?pickcustname="
			+"${fld:custall}&objid=cust_code&objidtwo=custall&unionorgid=unionorgid&random_number="+Math.random(), id:"rc1001", height:650});
}


/** 入场是否查询会员所有卡  后台设置入场规则有设置  **//*
if("${fld:custallcardvalue}"=="0"){
	if(count==1){
		var url="${def:context}${def:actionroot}/searchcard?custall="+custall+"&cardcode="+cardcode+"&unionorgid="
			+unionorgid+"&checkedcard="+cardcode;
		ajaxCall(url,{
			method:"GET",
			progress:true,
			dataType:"script",
			success:function(){
			}
		});
		var classdefurl="${def:context}${def:actionroot}/searchclassprepare?custall="+customercode+"&unionorgid="+unionorgid;
		search(classdefurl);
		$("#searchhtml").show();
	}else{
		$("#unionorgid").val("${def:org}");
		ccms.dialog.open({url : "${def:context}/action/project/fitness/util/querycustcardocdelist/crud?pickcustname="
				+"${fld:custall}&objid=cust_code&objidtwo=custall&random_number="+Math.random(), id:"rc1001", height:650});
	}
}else{
	$("#unionorgid").val("${def:org}");
	ccms.dialog.open({url : "${def:context}/action/project/fitness/util/querycustcardocdelist/crud?pickcustname="
			+"${fld:custall}&objid=cust_code&objidtwo=custall&random_number="+Math.random(), id:"rc1001", height:650});
}
*/