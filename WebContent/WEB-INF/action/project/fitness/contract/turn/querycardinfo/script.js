var num1="${fld:num}";
//zyb 20190529 续卡不可以转卡
if(num1>0){
	ccms.dialog.notice("有续卡不能转卡！", 2000);
	document.getElementById("cardcode").options.selectedIndex = 0;//重置值
	$("#cardcode").selectpicker("refresh");//刷新
}else{
	<card-rows>
	$("#cardcontractcode").val("${fld:contractcode}");
	$("#cardtypespan").text("${fld:cardtypename@js}");
	$("#startdatespan").text("${fld:startdate}");
	$("#enddatespan").text("${fld:enddate}");
	$("#newstartdatespan").text(new Date().format("yyyy-MM-dd"));
	$("#newenddatespan").text("${fld:enddate}");
	$("#startdate").val(new Date().format("yyyy-MM-dd"));
	$("#enddate").val("${fld:enddate}");
	$("#oldmcname").text("${fld:mcname@js}");
	$("#starttypespan").text("${fld:starttypename@js}");
	$("#supportorgsspan").text("${fld:supportorgs@js}");
</card-rows>
}


