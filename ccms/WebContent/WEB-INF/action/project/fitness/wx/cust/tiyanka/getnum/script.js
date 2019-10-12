var usenum=0;
var linglimit=0; //领取限制  null随便
var lingnum=0; //该电话已领多少张
var index=0;
var org_id = "";

<card>
index++;
if(index==1){
	usenum=parseInt("${fld:usenum}");
}else{
	lingnum=parseInt("${fld:usenum}");
}
</card>


var fakanum="";
<tiyanka>
	fakanum="${fld:totalnum}";
	linglimit="${fld:personnum}";
	org_id = "${fld:org_id}";
</tiyanka>



if(fakanum==""){
	if(linglimit!=""&& linglimit <= lingnum){//领取有限制
		 //领取小于已领
		ccms.dialog.notice("该手机号已超过领取限制");
	}else{
		location.href="${def:context}/action/project/fitness/wx/cust/tiyanka/lingka/form?"
			+"code="+$('#code').val()
			+"&org_id="+org_id
			+"&ecode="+$('#ecode').val()
			+"&cc_name="+$('#cc_name').val()
			+"&cc_sex="+$('#cc_sex').val()
			+"&cc_mobile="+$('#cc_mobile').val()
			+"&codes="+$('#codes').val()
			+"&customercode="+$('#customercode').val()
	}
}else{
	if(fakanum!=null && fakanum!="" && fakanum>usenum){
		if(linglimit!=""&&linglimit!=null && linglimit <= lingnum){//领取有限制
			 //领取小于已领
			ccms.dialog.notice("该手机号已超过领取限制");
		}else{
			location.href="${def:context}/action/project/fitness/wx/cust/tiyanka/lingka/form?"
				+"code="+$('#code').val()
				+"&org_id="+org_id
				+"&ecode="+$('#ecode').val()
				+"&cc_name="+$('#cc_name').val()
				+"&cc_sex="+$('#cc_sex').val()
				+"&cc_mobile="+$('#cc_mobile').val()
				+"&codes="+$('#codes').val()
				+"&customercode="+$('#customercode').val()
		}
}else{
	ccms.dialog.notice("体验卡已领完");
	}
}




/*if(fakanum!=null && fakanum!="" && fakanum>usenum){
	if(linglimit!=""&&linglimit!=null && linglimit < lingnum){//领取有限制
		 //领取小于已领
		ccms.dialog.notice("该手机号已超过领取限制");
	}else{
		location.href="${def:context}/action/project/fitness/wx/cust/tiyanka/lingka/form?"
			+"code="+$('#code').val()
			+"&org_id="+org_id
			+"&ecode="+$('#ecode').val()
			+"&cc_name="+$('#cc_name').val()
			+"&cc_sex="+$('#cc_sex').val()
			+"&cc_mobile="+$('#cc_mobile').val()
			+"&codes="+$('#codes').val()
			+"&customercode="+$('#customercode').val()
	}
}else{
	
	
	ccms.dialog.notice("体验卡已领完");
}*/
