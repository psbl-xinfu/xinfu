<rows>
$('#nation').text("${fld:nation}");
$('#name').text("${fld:name}");
$('#sex').text("${fld:sex}");
$('#mobile').text("${fld:mobile}");
var birth="${fld:birth}".substring(5,10);
if("${fld:birth}"!=''&&"${fld:birthday}"!=''){
	$('#birth').text("${fld:birth}月${fld:birthday}日");
}
$('#wx').text("${fld:wx}");
$('#qq').text("${fld:qq}");
$('#mc').text("${fld:mc}");

$('#type').text("${fld:type}");
$('#cardtype').text("${fld:cardtype@js}");
$('#card').text("${fld:card}");
$('#nationality').text("${fld:nationality}");
$('#nation').text("${fld:nation}");
$('#occupation').text("${fld:occupation}");
$('#province').text("${fld:province}"+"${fld:city}"+"${fld:addr}");

$('#email').text("${fld:email}");
$('#officename').text("${fld:officename@js}");
$('#officetel').text("${fld:officetel}");
$('#urgent').text("${fld:urgent}");
$('#othertel').text("${fld:othertel}");
$('#purpose').text("${fld:purpose}");

$('#leave').text("${fld:leave}");
$('#gethobbit').text("${fld:gethobbit}");
$('#personalhobbit').text("${fld:personalhobbit}");
$('#marriage').text("${fld:marriage}");

$('#children').text("${fld:children}");
$('#remark').text("${fld:remark@js}");

$('#recommend_name').text("${fld:recommend_name@js}");
$('#age').text("${fld:age}");

if( "" != "${fld:imgid}" ){
	$("#headpic").attr("src", contextPath+"/action/project/fitness/util/attachment/download?tuid=${fld:imgid}&type=1");
}else{
	$("#headpic").attr("src", contextPath+"/js/project/fitness/image/SVG/170X220.svg");
}


</rows>

