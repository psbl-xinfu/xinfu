$("#branchlis").empty();
var branchlis="";

 branchlis+='<label>店面</label> ';
 branchlis+='<select id="cc_branchcode" title="请选择" name="cc_branchcode" >';
<branch-rows>
	branchlis+='<option value="${fld:branchcode}">${fld:branchname}</option>';
</branch-rows>
 branchlis+='</select>';
$("#branchlis").append(branchlis);

searchSelectInit($("#cc_branchcode"));
setSelectValue($("#cc_branchcode"), "${fld:thebranchcode}");