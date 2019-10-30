<rows>

$('#nation').text("${fld:nation}");
$('#name').text("${fld:name@js}");
$('#sex').text("${fld:sex}");
$('#mobile').text("${fld:mobile}");
if("${fld:birth}"!=''&&"${fld:birthday}"!=''){
	$('#birth').text("${fld:birth}月${fld:birthday}日");
}
$('#wx').text("${fld:wx}");
$('#qq').text("${fld:qq}");
$('#mc').text("${fld:mc}");
$('#participate').text("${fld:participate}");

$('#type').text("${fld:type}");
$('#cardtype').text("${fld:cardtype}");
$('#card').text("${fld:card}");
$('#nationality').text("${fld:nationality}");
$('#nation').text("${fld:nation}");
$('#occupation').text("${fld:occupation}");
$('#province').text("${fld:province}"+"${fld:city}"+"${fld:addr@js}");

$('#email').text("${fld:email@js}");
$('#officename').text("${fld:officename@js}");
$('#officetel').text("${fld:officetel}");
$('#urgent').text("${fld:urgent}");
$('#othertel').text("${fld:othertel}");
$('#purpose').text("${fld:purpose}");
$('#brand').text("${fld:brand}");

$('#ismember').text("${fld:ismember}");
$('#leave').text("${fld:leave}");
$('#customtype').text("${fld:customtype}");
$('#gethobbit').text("${fld:gethobbit}");
$('#personalhobbit').text("${fld:personalhobbit}");
$('#marriage').text("${fld:marriage}");

$('#children').text("${fld:children}");
$('#remark').text("${fld:remark@js}");

$('#recommend_name').text("${fld:recommend_name@js}");
$('#age').text("${fld:age}");
$("#demand").text("${fld:demand}");

</rows>

