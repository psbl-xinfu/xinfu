
var count = 0;
var html = "";
<rows>
	var entrancetype = "${fld:entrancetype}";
	if(entrancetype==""){entrancetype="2";}
	count++;
	html+='<tr><td><input type="radio" ';
	if(count==1){
		html+='checked="checked" ';
	}
	var cardtype_name = "${fld:cardtype_name@js}";
	if(cardtype_name.length>10){
		cardtype_name = cardtype_name.substring(0,5)+"</br>"+cardtype_name.substring(5,10)
		+"</br>"+cardtype_name.substring(10,cardtype_name.length);
	}else if(cardtype_name.length>5){
		cardtype_name = cardtype_name.substring(0,5)+"</br>"+cardtype_name.substring(5,cardtype_name.length);
	}
	html+='class="cardcode" name="cardcode" cardstatus="${fld:cardstatus}" code2="${fld:type}" code3="${fld:org_id}" code="${fld:cardtype@js}" code1="'+entrancetype+'" codetype="1"  value="${fld:code@js}"></td>'
		+"<td>"+cardtype_name+"</td><td>${fld:carddate}</td><td>${fld:org_name@js}</td>";
	if("${fld:type}"=="0"){
		html+="<td>--</td>";
	}else if("${fld:type}"=="1"){
		html+="<td><input type='text' size='2' style='text-align:center' id='${fld:code}num' class='input-default inputnum' value='1'/></td>";
	}else if("${fld:type}"=="2"){
		html+="<td>--</td>";
	}
	html+="<td>${fld:status}</td></tr>";
</rows>
$("#cardlist").html(html);
$(".inputnum").blur(function(){
	var val = $(this).val();
	if(isNaN(parseInt(val))){
		$(this).val(1);
	}else if(parseInt(parseInt(val))<1){
		$(this).val(1);
	}
})

ccms.util.renderRadio("cardcode");

//
ccms.util.setCheckboxValue("cardcode","${fld:checkedcard}","searchForm");
//自动入场延迟秒数
var delaytimevalue = parseInt("${fld:delaytimevalue}")*1000;

if(count==0){
	$("#custcode,#name,#mobile,#mc,#pt,#cabinettempcode").html("");
	$(".error").html("");
	var url="${def:context}${def:actionroot}/searchlosscard?custall=${fld:custall}&unionorgid=${fld:unionorgid}";
	ajaxCall(url,{
		method : "get",
		progress : false,
		dataType : "script",
		success : function() {
			//判断是否自动入场
			if("${fld:automaticentryvalue}"=="1"){
				setTimeout(function(){
					$("#execution").click();
				}, delaytimevalue);
			}
		}
	});
}else{
	var val = getCheckboxValue("cardcode");
	var url="${def:context}/action/project/fitness/customer/entrance/searchcardinfo?cardcode="+val+"&unionorgid=${fld:unionorgid}";
	ajaxCall(url,{
		method : "get",
		progress : false,
		dataType : "script",
		success : function() {
			//判断是否自动入场
			if("${fld:automaticentryvalue}"=="1"){
				setTimeout(function(){
					$("#execution").click();
				}, delaytimevalue);
			}
		}
	});
}

//会员卡
$("input[name=cardcode]").on("ifClicked",function(){
	if($(this).attr("codetype")=="1"){
		if($(this).attr("code2")=="1")
			document.getElementById($(this).val()+"num").focus();
		var url="${def:context}/action/project/fitness/customer/entrance/searchcardinfo?cardcode="+$(this).val()+"&unionorgid=${fld:unionorgid}";
		search(url);
	}
});