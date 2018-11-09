
$("#tuid").val("${fld:tuid}");
$("#name").val("${fld:name@js}");
$("#mobile").val("${fld:mobile@js}");
$("#remark").val("${fld:remark@js}");


$("input[name=sex][value=${fld:sex}]").attr("checked", "checked");
$("input[name=age][value=${fld:age}]").attr("checked", "checked");
$("input[name=intention][value=${fld:intention}]").attr("checked", "checked");
$("input[name=isaddwx][value=${fld:isaddwx}]").attr("checked", "checked");
$("input[name=communication][value=${fld:communication}]").attr("checked", "checked");

if(${fld:type}==0){
	
	$(".save-btn").hide();
	$(".cancel-btn").css('width','270px');
}

$("#demand").val("${fld:demand}");
var demand = "${fld:demand}".split(",");
if("${fld:demand}"!=""){
	for (var i=0;i<demand.length ;i++ ) { 
		ccms.util.setCheckboxValue('demandcb',demand[i],'formEditor');
		$("input[name=demandcb][value="+demand[i]+"]").parent().addClass("w1");
	} 
}