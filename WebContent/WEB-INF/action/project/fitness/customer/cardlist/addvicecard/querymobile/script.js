
if(parseInt("${fld:num}")>0){
	$("#mobile").val("");
	$Dialog().confirm("已存在该会员，副卡是否关联该会员？", function(){
		<rows>
			$("#name").val("${fld:name}");
			$("#mobile").val("${fld:mobile}");
			setSelectValue($("#sex"), "${fld:sex}");
			setSelectValue($("#age"), "${fld:age}");
			setSelectValue($("#cardtype"), "${fld:cardtype}");
			$("#card").val("${fld:card}");
			$("#urgent").val("${fld:urgent}");
			$("#othertel").val("${fld:othertel}");
		</rows>
	});
}
