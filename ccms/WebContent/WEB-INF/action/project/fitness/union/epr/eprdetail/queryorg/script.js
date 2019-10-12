

<org-rows>
	//根据俱乐部查询统计记录
	ajaxCall("${def:actionroot}/search?date=${fld:date}&org_id=${fld:org_id}&org_name=${fld:org_name}",{
		method:"get",
		dataType:"script",
		success:function(){
		}
	});
</org-rows>

