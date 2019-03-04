if("${fld:num}"==1){
	ccms.dialog.notice("该用户已经存在，不可以转店！",2000,function(){
		window.location.href= "${def:context}/action/project/fitness/customer/trunshops/crud";
	});

}else{
	var ptstr = "<option value=''>全部会籍</option>";
	<rows>
		ptstr+="<option value='${fld:userlogin}'>${fld:name}</option>"
	</rows>
	$("#turnclasspt").html(ptstr);

	$("#turnclasspt").selectpicker("refresh");
	$("#turnclasspt").selectpicker("render");
}
