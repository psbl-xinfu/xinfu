<rows1>
document.formEditor.vc_code.value = "${fld:code}";
setSelectValue($("#vc_cardcategory"), "${fld:type}");
setSelectValue($("#vc_type"), "${fld:cardcategory}");
document.formEditor.vc_name.value = "${fld:name}";
document.formEditor.count.value = "${fld:count}";
document.formEditor.daycount.value = "${fld:daycount}";
document.formEditor.vc_giveday.value = "${fld:giveday}";
document.formEditor.vc_remark.value = "${fld:remark@js}";
document.formEditor.vc_ptcount.value = "${fld:ptcount}";
document.formEditor.vc_color.value = "${fld:bgcolor}";
document.formEditor.vc_cardfee.value = "${fld:cardfee}";
document.formEditor.vc_minfee.value = "${fld:minfee}";
document.formEditor.moneyleft.value = "${fld:moneyleft}";
document.formEditor.opencarddeadline.value = "${fld:opencarddeadline}";
$('.color').blur();
$('#support').html('');
$('#salelist').html('');
$('#timeinterallist').html('');
/*if("${fld:maxusernum}"==1||"${fld:maxusernum}"==""){
	setSelectValue($("#maxusernum"), "0");
}else{
	setSelectValue($("#maxusernum"), "1");
}*/
if("${fld:type}"=="1"){
	$("#count").show();
	$("#countlable").html("可用次数：");
}

if("${fld:mealdiscount}"!=0){
	appendSale();
	var len=$('.salesChoice').length-1;
	$('.salesChoice').eq(len).val('z1');
	$('.salesChoice').eq(len).parent().next().next().children().val(parseInt("${fld:mealdiscount}"));
}

if("${fld:drinkdiscount}"!=0){
	appendSale();
	var len=$('.salesChoice').length-1;
	$('.salesChoice').eq(len).val('z2');
	$('.salesChoice').eq(len).parent().next().next().children().val(parseInt("${fld:drinkdiscount}"));
}

if("${fld:jsdiscount}"!=0){
	appendSale();
	var len=$('.salesChoice').length-1;
	$('.salesChoice').eq(len).val('z3');
	$('.salesChoice').eq(len).parent().next().next().children().val(parseInt("${fld:jsdiscount}"));
}

if("${fld:swimdiscount}"!=0){
	appendSale();
	var len=$('.salesChoice').length-1;
	$('.salesChoice').eq(len).val('z4');
	$('.salesChoice').eq(len).parent().next().next().children().val(parseInt("${fld:swimdiscount}"));
}


if("${fld:singlediscount}"!=0){
	appendSale();
	var len=$('.salesChoice').length-1;
	$('.salesChoice').eq(len).val('z5');
	$('.salesChoice').eq(len).parent().next().next().children().val(parseInt("${fld:singlediscount}"));
}

if("${fld:classdiscount}"!=0){
	var len=$('.salesChoice').length-1;
	appendSale();
	$('.salesChoice').eq(len).val('z6');
	$('.salesChoice').eq(len).parent().next().next().children().val(parseInt("${fld:classdiscount}"));
}

getShop("${fld:union_id}");
</rows1>

<rows2>
appendTime();
var len=$('.timeChoice').length-1;
$('.timeChoice').eq(len).val('${fld:weekday}');
$('.timeChoice').eq(len).parent().find("input[name=starttime1]").val("${fld:starttime1}");
$('.timeChoice').eq(len).parent().find("input[name=endtime1]").val("${fld:endtime1}");
</rows2>


<rows-discount>
//add by leo 20190521 解决修改折扣重复显示问题
//appendSale();
var len=$('.salesChoice').length-1;
$('.salesChoice').eq(len).val('${fld:storage}');
$('.salesChoice').eq(len).parent().find("input[name=discount]").val("${fld:discount}");
</rows-discount>

