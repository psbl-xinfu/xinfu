
var count = 0;
var str = "";
<rows>
	count++;
	//挂失
	if("${fld:status}"=="4"){
		str+="${fld:code}  ${fld:cardtype_name}  挂失中</br>";
	}
	//未启用
	if("${fld:status}"=="2"){
		str+="${fld:code}  ${fld:cardtype_name}  未启用</br>";
	}
	//停卡中
	if("${fld:status}"=="5"){
		str+="${fld:code}  ${fld:cardtype_name}  停卡中</br>";
	}
	//过期
	if("${fld:status}"=="6"){
		str+="${fld:code}  ${fld:cardtype_name}  已过期</br>";
	}
</rows>
if(count==0){
	$("#errorinfo").html("未查询到会员卡！");
}else{
	$("#errorinfo").html(str);
}
