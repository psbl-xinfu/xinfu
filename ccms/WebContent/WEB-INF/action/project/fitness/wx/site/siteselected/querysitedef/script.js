$(".bcsitedeflist,.pcsitedeflist,#yylist").html("");
$("#totalprice").html("0元");
//最小开场时间
var minhour = parseInt("${fld:minhour}");
//最大闭场时间
var maxhour = parseInt("${fld:maxhour}");
$("#minhour").val(minhour);
$("#maxhour").val(maxhour);

var sitedefhour = "<div style='height:0.43rem;'></div>";
for(var i=minhour;i<=maxhour;i++){
	sitedefhour+="<em>"+i+":00</em>";
}
if("${fld:choose_way}"=="1"){
	$("#bchour").html(sitedefhour);
}else if("${fld:choose_way}"=="2"){
	$("#pchour").html(sitedefhour);
}

<sitedef-rows>
	var sitename = "${fld:sitename@js}";
	if(sitename.length>5){
		sitename = sitename.substring(0,5);
	}
	var sitedeflist ="<dl><dt>"+sitename+"</dt>";
	for(var j=minhour;j<=maxhour;j++){
		var color = "grey";
		ajaxCall("${def:actionroot}/querysiteusedetail?sitecode=${fld:code}&limittime="
				+j+":00:00&time="+j+"&prepare_date=${fld:prepare_date}&prepare_type=${fld:choose_way}&org_id=${fld:org_id}",{
			method:"get",
			dataType:"json",
			async:false,
			success:function(data){
				var choose_way = data.choose_way;
				var yynum = data.yynum;
				if(choose_way.length>0){
					if("${fld:choose_way}"=="1"&&yynum==0&&choose_way=="${fld:choose_way}"){
						color="";
					}else if("${fld:choose_way}"=="2"&&yynum<parseInt("${fld:group_maxnum}")&&choose_way=="${fld:choose_way}"){
						color="";
					}
				}
			}
		});

		//包场
		if("${fld:choose_way}"=="1"){
			sitedeflist+="<dd class='"+color+"' codeprice='${fld:block_price}' codestr='${fld:sitename@js}' code='${fld:code}' hour='"
			+j+"'>${fld:block_maxnum}人<br>￥${fld:block_price} </dd>";
		}
		//拼场
		if("${fld:choose_way}"=="2"){
			sitedeflist+="<dd class='"+color+"' codeprice='${fld:group_price}' codestr='${fld:sitename@js}' code='${fld:code}' hour='"
			+j+"'>${fld:group_minnum}/${fld:group_maxnum}人<br>￥${fld:group_price}</dd>";
		}
	}
	sitedeflist+="</dl>";
	if("${fld:choose_way}"=="1"){
		$(".bcsitedeflist").append(sitedeflist);
	}
	if("${fld:choose_way}"=="2"){
		$(".pcsitedeflist").append(sitedeflist);
	}
</sitedef-rows>

$('#siteItem dd').click(function () {
    if ($(this).hasClass("grey")) {

    } else {
        if (!$(this).hasClass("blue")) {
            $(this).addClass("blue");
            $("#yylist").append("<div codeprice='"+$(this).attr("codeprice")+"' code='"+$(this).attr("code")+"' hour='"+$(this).attr("hour")+"'>"
            		+$(this).attr("codestr")+"<br>"+$(this).attr("hour")+":00</div>");
            totalprice();
        } else {
            $(this).removeClass("blue");
            $("#yylist [code="+$(this).attr("code")+"][hour="+$(this).attr("hour")+"]").remove();
            totalprice();
        }
    }
});


function querysitedefbycode(code){
	$("#sitekxdate").html("");
	//查询场地信息
	ajaxCall("${def:actionroot}/querysitedefbycode?code="+code+"&site_timelimitcode="+$("#site_timelimitcode").val(),{
		method:"get",
		dataType:"script",
		success:function(){
		}
	});
}
//计算金额
function totalprice(){
	var price = 0;
	$("#yylist div").each(function(){
		price+=Number($(this).attr("codeprice"));
	});
	$("#totalprice").html(Number(price).toFixed(2)+"元");
	$("#yyinputprice").val(Number(price).toFixed(2));
}