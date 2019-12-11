var custstr = "", custnum = 0, custcode = "", homeunionorgid;
if( $("#modalPickCust").length > 0 ){
	$("#modalPickCust").empty();
}else{
	custstr = '<div class="modal fade" id="modalPickCust" tabindex="-1" role="dialog">';
	custstr += '</div>';
	$("body").append(custstr);
}
custstr = '<div class="modal-dialog normalbg" style="width:330px;">';
custstr += '<div class="modal-content">';
custstr += '<div class="modal-header">';
custstr += '<button type="button" class="close" style="padding-left:80px;" data-dismiss="modal" aria-hidden="true">&times;</button>';
custstr += '<h4 class="modal-title" id="formTitle">选择联系人</h4>';
custstr += '</div>';
custstr += '<div class="r-tab-cout-3-b"><div class="to-change-background"></div>';
custstr += '<table class="am-table"><thead><tr>';
custstr += '<th nowrap>公司名称</th>';
custstr += '<th nowrap>联系人</th>';
custstr += '<th nowrap>职位</th>';
custstr += '<th nowrap>手机号码</th>';
custstr += '</tr>';
custstr += '</thead>';
custstr += '<tbody id="custList">';

<rows>
custstr += '<tr onclick="javascript:pickCust('+custnum+',\'${fld:guestcode@js}\',\'${fld:thename@js}\', \'${fld:homeunionorgid}\')" title="单击选择该会员">';
custstr += '<td nowrap class="text-center">${fld:officename@js}</td>';
custstr += '<td nowrap class="text-center">${fld:thename@js}</td>';
custstr += '<td nowrap class="text-center">${fld:posname@js}</td>';
custstr += '<td nowrap class="text-center">${fld:themobile@js}</td>';
custstr += '</tr>';
custcode = "${fld:guestcode}";
homeunionorgid = "${fld:homeunionorgid}";
custnum++;
</rows>

custstr += '</tbody>';
custstr += '</table>';
custstr += '</div>';
custstr += '<div class="modal-footer"></div>';
custstr += '</div>';
custstr += '</div>';
		
function pickCust(idx, code,name, homeunionorgid){
	$("#pickcustname").val(name);
	$("#${fld:objid}").val(code);
	$("#${fld:homeunionorgid}").val(homeunionorgid);
	$("#modalPickCust").modal("hide");
	$("#modalPickCust").next("div.modal-backdrop").remove();
	$("#modalPickCust").empty();
	if( typeof(pickcustCallback) == "function" ){
		pickcustCallback();
	}else if( typeof(parent.pickcustCallback) == "function" ){
		parent.pickcustCallback();
	}
}


if( custnum > 1 ){
	$("#modalPickCust").append(custstr);
	$("#modalPickCust").modal("show");
	$("#${fld:objid},#${fld:homeunionorgid}").val("");
}else if( custnum == 1 ){
	$("#${fld:objid}").val(custcode);
	$("#${fld:homeunionorgid}").val(homeunionorgid);
}else{
	ccms.dialog.notice("不存在该联系人，请检查！", 2000);
	$("#${fld:objid},#${fld:homeunionorgid}").val("");
}