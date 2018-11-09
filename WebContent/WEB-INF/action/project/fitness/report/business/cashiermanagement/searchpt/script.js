var str=''	
	str += '<option value="">全部业务类型</option>'
<rows>
str += '<option value="${fld:code@js}">${fld:ptlevelname@js}</option>'

</rows>
$('#yewuleixing').html();
$('#yewuleixing').html(str);
$('#yewuleixing').selectpicker("refresh");
$('#yewuleixing').selectpicker("render");