
var html = "";
<rows>
	html+="<tr><td>${fld:application_id@js}</td><td>${fld:ptlevelname@js}</td><td>${fld:staff_name@js}</td>"
		+"<td>1课时</td><td>${fld:ptleftcount}</td><td>${fld:preparedate@yyyy-MM-dd HH:mm}</td><td>${fld:createdby}</td></tr>";
</rows>
$("#datagridTemplate").html(html);

ccms.util.renderRadio("ptpcode");

//手牌号
$("#cabinettempcode").html("${fld:cabinettempcode@js}");
$("#shoupai").val("${fld:cabinettempcode@js}");

//课程选择
$("input[name=ptpcode]").on("ifClicked",function(){
	var url="${def:context}/action/project/fitness/customer/brushclass/searchptprepareinfo?ptpcode="+$(this).val();
	searchcust(url);
});