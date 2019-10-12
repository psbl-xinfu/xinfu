
$("#bcnum").html("${fld:block_maxnum}");
$("#bcprice").html("${fld:block_price}");
$("#pcprice").html("${fld:group_price}");
$("#pcminnum").html("${fld:group_minnum}");
$("#pcmaxnum").html("${fld:group_maxnum}");

$("#sitecode").val("${fld:code}");

$("#sitedefkxname").html("<label style='width:120px;'>当前场地：</label>${fld:sitename}");

var sitekxdate = "<label style='width:120px;'>可设置时间段：</label>"
	+"<input type='checkbox' id='sitecheckall' name='sitecheckall' /><label style='width:30px;'>全部</label>";
//最小开场时间
var minhour = parseInt("${fld:opening_date}");
//最大闭场时间
var maxhour = parseInt("${fld:closed_date}");

for(var i=minhour;i<=maxhour;i++){
	ajaxCall("${def:actionroot}/querysitetimelimit?sitecode=${fld:code}&limittime="+i,{
		method:"get",
		dataType:"json",
		async:false,
		success:function(data){
			if(data.num=="0"){
				sitekxdate+="<input type='checkbox' name='sitecheckbox' value='"+i+"' /><label style='width:30px;'>"+i+":00</label>";
			}
		}
	});
}
if("${fld:site_timelimitcode}"==""||"${fld:site_timelimitcode}"==undefined){
	//场地可设置时间段
	$("#sitekxdate").html(sitekxdate);
	ccms.util.renderCheckbox("sitecheckbox");
	ccms.util.renderCheckbox("sitecheckall");
}

//全选   取消全选
$("#sitecheckall").unbind().on("ifClicked", function () {    //点击事件未选中
	if ($(this).prop("checked")) {// 
		$('input[name=sitecheckbox]').iCheck('uncheck');
	} else {
		$('input[name=sitecheckbox]').iCheck('check');  //
	}
});

