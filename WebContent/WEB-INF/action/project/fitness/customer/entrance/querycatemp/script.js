var ptstr="";
ptstr+="<option value=''>全部手牌号</option>";
	<cabinettemp-list>
		ptstr+="<option value='${fld:inettemptuid}'>${fld:inettemptname} ${fld:inettemptstatus}</option>";
	</cabinettemp-list>
	
$("#rudge_code").html(ptstr);
$("#rudge_code").selectpicker("refresh");
$("#rudge_code").selectpicker("render");
