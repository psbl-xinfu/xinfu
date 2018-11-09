
//判断权限 1大队长2组长3组员
if("${fld:usertype}"=="1"){
	$("#groupicon").attr("data-type", "data");
	$("#groupspanicon").attr("class", "icon-bar_table");
}else if("${fld:usertype}"=="2"){
	$("#groupicon").attr("data-type", "add");
	$("#groupspanicon").attr("class", "icon-add");
}