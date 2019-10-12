var count = 0;
<t-row>
count++;
$("#cust_code").val("${fld:expercardlogcode@js}");
$("#cust_name").val("${fld:name@js}");
$("#cardtype").val("${fld:expercarddef_code@js}");
$("#name").html("${fld:name@js}");
$("#mobile").html("${fld:mobile@js}");
$("#cardtype_name").html("${fld:expercardname@js}");
$("#custcodeone").html("${fld:code@js}");
$("#unionorgid").val("${fld:org_id}");
$("#rudge_code").selectpicker("val", "${fld:cabinettempcode}");//给下拉框赋值
$("#rudge_code").selectpicker("refresh");//刷新
if("${fld:expertype}"=="0"){
	$("#errorinfo").html("时效卡");
}else if("${fld:expertype}"=="1"){
	$("#errorinfo").html("此卡有效,次数剩余${fld:experlimit}次！");
}

var expercardname = "${fld:expercardname@js}", html = "";
var entrancetype = "${fld:entrancetype}";
if(entrancetype==""){entrancetype="2";}
html+='<tr><td><input type="radio" ';
html+='checked="checked" ';
if(expercardname.length>10){
	expercardname = expercardname.substring(0,5)+"</br>"+expercardname.substring(5,10)
	+"</br>"+expercardname.substring(10,expercardname.length);
}else if(expercardname.length>5){
	expercardname = expercardname.substring(0,5)+"</br>"+expercardname.substring(5,expercardname.length);
}
html+='class="cardcode" name="cardcode" cardstatus="${fld:cardstatus}" code2="${fld:expertype}" code="${fld:expercarddef_code@js}" code1="'+entrancetype+'" codetype="2" value="${fld:code@js}"></td>'
	+"<td>"+expercardname+"</td><td>${fld:enddate}</td><td>${fld:org_name@js}</td>";
if("${fld:expertype}"=="0"){
	html+="<td>--</td>";
}else if("${fld:expertype}"=="1"){
	html+="<td><input type='text' size='2' style='text-align:center' id='${fld:code}num' class='input-default inputnum' value='1'/></td>";
}
var status = "${fld:status}";
if("${fld:cardstatus}"=="2"){
	status = "已过期";
}
html+="<td>"+status+"</td></tr>";
$("#cardlist").html(html);
$(".inputnum").blur(function(){
	var val = $(this).val();
	if(isNaN(parseInt(val))){
		$(this).val(1);
	}else if(parseInt(parseInt(val))<1){
		$(this).val(1);
	}
});
ccms.util.renderRadio("cardcode");

$(".error").html("");
$("#headpic").attr("src", contextPath+"/js/project/fitness/image/SVG/170X220.svg");

$("#searchhtml").show();
</t-row>
if(count==0){
	ccms.dialog.notice("没有该体验卡！", 2000);
}