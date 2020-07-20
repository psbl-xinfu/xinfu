$("#branch").empty();
branchstr="";
<branch-rows>
/*<input type="hidden" name="menuorgid" id="menuorgid" value="${fld:menuorgid}" />
*/	if("${fld:states}"==0){
	branchstr+='<span class="lable3">主店名称：</span>';
	branchstr+='<span class="lable4" id="storename">${fld:storename}</span>';
	branchstr+='<span class="lable3">主店地址：</span>';
	branchstr+='<span class="lable4" id="address">${fld:address}</span>';
}else{
	branchstr +='<span class="lable3">分店名称:</span>' ;
	branchstr +='<span class="lable4" id="storename">${fld:storename}</span>';
	branchstr +='<span class="lable3">分店地址:</span>';
	branchstr +='<span class="lable4" id="address">${fld:address}</span>';
	
}
</branch-rows>


$("#branch").append(branchstr); 

$("#salelist").empty();
							 fend="";
							 <branch-rows1>
								 if("${fld:states}"==0){
									 fend +='<li >'; 			
									 fend +='<label>主店名称</label> ';
									 fend +='<input type="text" id="storename" name="storename" value="${fld:storename}" maxlength="80" placeholder="主店名称" />	';
									 fend +='<label>主店地址</label> ';
									 fend +='<input  type="text" id="address" name="address" value="${fld:address}" maxlength="500" placeholder="地址详细信息" />	';
									 fend += '&nbsp;&nbsp;&nbsp;&nbsp;';
									 fend +='<i class="am-icon-plus" id="addpay_btnbin1" title="添加"></i>';
									 fend +='<label  style="color:red" id="update_btnbranch">修改</label>';
									 fend +='<input type="hidden"  name="states" value="0" />	';
									 fend +='<input type="hidden"  name="branchcode" value="${fld:branchcode}" />	';
									 fend +='</li>';
								 }else{
									 fend +='<li>';
									 fend +='<label>分店名称</label>' ;
									 fend +='<input type="text" id="storename" name="storename" value="${fld:storename}" maxlength="80" />';
									 fend +='<label>分店地址</label>';
									 fend +='<input type="text" id="address" name="address" value="${fld:address}"  maxlength="500"/>';
									 fend +='&nbsp;&nbsp;&nbsp;&nbsp;';
									 fend +='<label  style="color:red" onclick="removeObj(${fld:branchcode})">删除</label>';
									 fend +='<label  style="color:red" id="update_btnbranch">修改</label>';
									 fend +='<input type="hidden"  name="branchcode" value="${fld:branchcode}" />	';
									 fend +='</li>';
								 }
							 </branch-rows1>
							 $("#salelist").append(fend);
							 $("#addpay_btnbin1").on("click",function(e){
								   $("#storenameaddup").val("");
								   $("#addressaddup").val("");
									//appendSale();
									$("#modalAddnew").modal('hide'); 
									$("#modalAddbranch").modal('show');
									
							});