<rows>

$('#officename').text("${fld:officename}");
$('#guestnum').text("${fld:guestnum}");
$('#officetel').text("${fld:othertel}");
$('#thepublic').text("${fld:thepublic}");
/*if("${fld:birth}"!=''&&"${fld:birthday}"!=''){
	$('#birth').text("${fld:birth}月${fld:birthday}日");
}*/
$('#province').text("${fld:city}"+"${fld:province}");
$('#email').text("${fld:email}");
$('#mc').text("${fld:mc}");
$('#cc_birth').text("${fld:customtype}");
$('#cc_channel').text("${fld:channel}");

$('#communication').text("${fld:communication}");

var custclass="${fld:custclass}";
var arr=custclass.split(",");
/* var custcationsarry =custclass.split(",").length ;*/
 var custcations="";
for (var i = 0; i < arr.length; i++) {
	if(arr[i]==1){
		custcations+="殊途设计;";
	}
	if(arr[i]==2){
		custcations+="殊途品牌;";
	}
	if(arr[i]==3){
		custcations+="单次学习;";
	}
	if(arr[i]==4){
		custcations+="全年学习;";
	}
	if(arr[i]==5){
		custcations+="6+1学习;";
	}
	if(arr[i]==6){
		custcations+="学习点客户;";
	}
	if(arr[i]==7){
		custcations+="内训客户;";
	}
	
}
$('#custcations').text(custcations.substr(0, custcations.length - 1) );
$('#remark').text("${fld:remark}");


</rows>
var branchnum=0;
var branchstr="";
<branch-rows>
	branchnum++;
	if(branchnum==1){
		branchstr+='<span class="lable3">主店名称：</span>';
		branchstr+='<span class="lable4" id="storename"></span>';
		branchstr+='<span class="lable3">主店地址：</span>';
		branchstr+='<span class="lable4" id="address"></span>';
	}else{
		
		branchstr +='<span class="lable3">分店'+branchnum+'名称</label> ';
		branchstr +='<span class="lable4" id="storename"></span>';	
		branchstr +='<span class="lable3">分店地址：</span> ';
		branchstr +='<span class="lable4" id="address"></span>';	
		branchstr +='<label  style="color:red" onclick="removeObj(this)">删除</label>';
		
	}
</branch-rows>
$("#branch").append(branchstr);
