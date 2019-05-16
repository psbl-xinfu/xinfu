
var orderlist = "";
<rows>
	orderlist+="<div class='order'><div class='data'>${fld:prepare_date@yyyy-MM-dd}</div>"
			+"<div class='order_num'>订单编号：${fld:code}</div>"
			+"<div class='order_cont'><div><p class='lt'>${fld:sitename@js}</p>"
	        +"<p class='lt'>${fld:prepare_starttime}-${fld:prepare_endtime}</p><span class='rt price'>￥${fld:normalmoney}</span>"
	        +"</div></div><div class='order_type'>";
	/*if("${fld:paystatus}"=="0"&&"${fld:zfstatus}"=="1"){
		orderlist+="<div class='pay_i' onclick='paysidef(\"${fld:code}\", \"${fld:normalmoney}\")' style='float: right;margin-top: 0.2rem;'></div>";
	}*/
	orderlist+="<p> 场地类型：<span class='site_type'>${fld:prepare_type@js}</span></p><p class='bao_team'>包场团体：${fld:groupname@js}"
	        +"</p><p>预订客户：${fld:name@js}；${fld:mobile@js}</p></div></div>";
</rows>
$("#orderlist").html(orderlist);


//支付
/*function paysidef(code, normalmoney){
	ajaxCall("${def:actionroot}/pay1?code="+code,{
		method:"get",
		dataType:"script",
		success:function(){
			ccms.dialog.notice("成功！", 2000, function(){
				history.go(0);
			});
		}
	});
}
*/
