

$("#tuid").val("${fld:tuid}");
$("#title").val("${fld:title}");
$("#content").val("${fld:content}");
$("#status").val("${fld:status}");
var color = "";
if(${fld:level}==1){
	color = "red";
}else if(${fld:level}==2){
	color = "yellow";
}else if(${fld:level}==3){
	color = "green";
}
$("#dot").attr("class", "dot "+color);
