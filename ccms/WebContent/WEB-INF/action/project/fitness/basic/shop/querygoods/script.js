
var goodslist = "", count = 0, oneid = "", twoid = "";
<rows>
	oneid = "${fld:gptuid}";
	twoid = "${fld:goodid}";
	var count1 = 0;
	$("input[name='gptuidcheckbox']:checkbox").each(function(){ 
		if($(this).val()=="${fld:gptuid}"){
			count1++;
		}
	});
	var price = 0;
	if($("#staff_type").val()=="1"){
		price = "${fld:staff_price}";
	}else{
		price = "${fld:price}";
	}
	if($("#goodslist").find("tr:last").find("td").eq(1).html()==undefined){
		count = 1;
	}else{
		count = parseInt($("#goodslist").find("tr:last").find("td").eq(1).html())+1;
	}
	if(count1==0){
		goodslist+="<tr><td class='table-checkbox'><input type='checkbox' name='gptuidcheckbox' value='${fld:gptuid}'></td>"
				+"<td>"+count+"</td><td>${fld:goods_name}</td><td>${fld:standard}</td><td>${fld:unit}</td><td id='${fld:gptuid}pricetd'>"+price+"</td>"
				+"<input type='hidden' id='${fld:gptuid}price' value='${fld:price}'>"
				+"<input type='hidden' id='${fld:gptuid}staff_price' value='${fld:staff_price}'>"
				+"<input type='hidden' name='goodid' value='${fld:goodid}'>"
				+"<input type='hidden' id='${fld:gptuid}formprice' name='price' value='"+price+"'>"
				+"<input type='hidden' name='gptuid' code='${fld:goodid}' value='${fld:gptuid}'>"
				+"<td id='shop'  ><div style='margin-top:-3px'><span style='font-size:28px'   onclick='reduceNum(\"${fld:gptuid}num\")'  >-</span>"
				+"<input type='text' size='2' style='text-align:center;margin-top:-8px' id='${fld:gptuid}num' name='goodsnum' onblur=\"goodsprice('${fld:gptuid}', '${fld:goodid}')\" class='input-default inputnum' value='1'/>"
				+"<span style='font-size:	24px;'  onclick='addNum(\"${fld:gptuid}num\")'>+</span><div></td>"
				+"<td id='${fld:gptuid}drinkdiscount'>"+parseInt($("#drinkdiscount").val())*100+"</td><td id='${fld:gptuid}money'>"+price+"</td></tr>"
				+"<input type='hidden' id='${fld:gptuid}tdmoney' name='tdmoney' value='"+price+"'>";
	}else{
		$("#${fld:gptuid}num").val(parseInt($("#${fld:gptuid}num").val())+1);
		var url = "${def:actionroot}/querygoodquantity?gptuid=${fld:gptuid}&goodid=${fld:goodid}";
		ajaxCall(url,{
			method:"get",
			progress:true,
			dataType:"json",
			success:function(data){
				if(data.quantity>0){
					goodsprice("${fld:gptuid}", "${fld:goodid}");
				}else{
					$("#${fld:gptuid}num").val("0");
					ccms.dialog.notice("该商品已卖完！", 2000);
				}
			}
		});
	}
</rows>
var url = "${def:actionroot}/querygoodquantity?gptuid="+oneid+"&goodid="+twoid;
ajaxCall(url,{
	method:"get",
	progress:true,
	dataType:"json",
	success:function(data){
		if(data.quantity>0){
			$("#goodslist").append(goodslist);
			ccms.util.renderCheckbox("gptuidcheckbox");
			calculate();
		}else{
			ccms.dialog.notice("该商品已卖完！", 2000);
		}
	}
});


function goodsprice(gptuid, goodid){
	var num = $("#"+gptuid+"num").val();
	if(isNaN(num)){
		num=1;
	}else{
		num = parseInt(num);
	}
	num = (num <1 ? 1 : num);
	var url = "${def:actionroot}/querygoodquantity?gptuid="+gptuid+"&goodid="+goodid;
	ajaxCall(url,{
		method:"get",
		progress:true,
		dataType:"json",
		success:function(data){
			if(data.quantity<parseInt(num)){
				if(data.quantity>0){
					$("#"+gptuid+"num").val(parseInt(data.quantity));
					num = data.quantity;
				}else{
					$("#"+gptuid+"num").val("0");
					num = 0;
					ccms.dialog.notice("该商品已卖完！", 2000);
				}
			}
			var price = 0;
			if($("#staff_type").val()=="1"){
				price = $("#"+gptuid+"staff_price").val();
			}else{
				price = $("#"+gptuid+"price").val();
			}
			$("#"+gptuid+"num").val(num);
			$("#price").val(price);
			var drinkdiscount = parseInt($("#drinkdiscount").val());
			$("#"+gptuid+"money").html(Number(num*price*drinkdiscount).toFixed(2));
			$("#"+gptuid+"tdmoney").val(Number(num*price*drinkdiscount).toFixed(2));
			calculate();
		}
	});
}
