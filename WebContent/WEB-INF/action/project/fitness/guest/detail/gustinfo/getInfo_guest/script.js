var guestcode="";
<rows>
	guestcode="${fld:guestcode}";
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
 <product-rows>
 	for (var i = 0; i < arr.length; i++) {
		if(arr[i]=="${fld:procode}"){
			custcations+="${fld:proname};";
		}
		
	}
 </product-rows>

$('#custcations').text(custcations.substr(0, custcations.length - 1) );
$('#remark').text("${fld:remark}");


</rows>
var branchnum=0;

<branch-rows>
	/*<input type="hidden" name="menuorgid" id="menuorgid" value="${fld:menuorgid}" />
*/	if("${fld:states}"==0){
		branchstr+='<span class="lable3">主店名称：</span>';
		branchstr+='<span class="lable4" id="storename">${fld:storename}</span>';
		branchstr+='<span class="lable3">主店地址：</span>';
		branchstr+='<span class="lable4" id="address">${fld:address}</span>';
	}else{
		branchstr +='<span class="lable3">分店'+branchnum+'名称:</span>' ;
		branchstr +='<span class="lable4" id="storename">${fld:storename}</span>';
		branchstr +='<span class="lable3">分店'+branchnum+'地址:</span>';
		branchstr +='<span class="lable4" id="address">${fld:address}</span>';
		
	}
	branchnum++;
</branch-rows>


$("#branch").append(branchstr); 



