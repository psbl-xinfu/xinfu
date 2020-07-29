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
							 var branchcinum=0;
							 <branch-rows1>
								 if("${fld:states}"==0){
									 fend +='<li >'; 			
									 fend +='<label>主店名称</label> ';
									 fend +='<input type="text" id="storename" name="storename" value="${fld:storename}" maxlength="80" placeholder="主店名称" />	';
									 fend +='<label>主店地址</label> ';
									 fend +='<input  type="text" id="address" name="address" value="${fld:address}" maxlength="500" placeholder="地址详细信息" />	';
									 fend += '&nbsp;&nbsp;&nbsp;&nbsp;';
									 fend +='<i class="am-icon-plus" id="addpay_btnbin1" title="添加"></i>';
									 fend +='&nbsp;&nbsp;&nbsp;&nbsp;';
									 fend +='<label6  style="color:red" onclick="updateObj(\'${fld:branchcode}\',\'${fld:storename}\',\'${fld:address}\')">修改</label>';
									 fend +='<input type="hidden"  name="states" value="0" />	';
									 fend +='</li>';
								 }else{
									 fend +='<li>';
									 fend +='<label>分店名称</label>' ;
									 fend +='<input type="text" id="storename" name="storename" value="${fld:storename}" maxlength="80" />';
									 fend +='<label>分店地址</label>';
									 fend +='<input type="text" id="address" name="address" value="${fld:address}"  maxlength="500"/>';
									 fend +='&nbsp;&nbsp;&nbsp;&nbsp;';
									 fend +='<label6  style="color:red" onclick="removeObj(${fld:branchcode})">删除</label6>';
									 fend +='&nbsp;&nbsp;&nbsp;&nbsp;';
									 fend +='<label6  style="color:red" onclick="updateObj(\'${fld:branchcode}\',\'${fld:storename}\',\'${fld:address}\')">修改</label6>';
									 fend +='</li>';
								 }
								 branchcinum++;
							 </branch-rows1>
							 $("#salelist").append(fend);
							 $("#addpay_btnbin1").on("click",function(e){
								   $("#storenameaddup").val("");
								   $("#addressaddup").val("");
								   if(branchcinum>0){
								   var branchci="";
									$("#branchzhu").empty();
									$("#formTitle").text("添加分店");
									branchci +=' <label>分店名称</label>';
									branchci +=' <input type="text" id="storenameaddup" name="storenameaddup" value="" maxlength="80" />';
									branchci +='<label>分店地址</label>';
									branchci +='<input type="text" id="addressaddup" name="addressaddup" value=""  maxlength="500"/>';
									 $("#branchzhu").append(branchci);
								   }
									//appendSale();
									$("#modalAddnew").modal('hide'); 
									$("#modalAddbranch").modal('show');
									
							});
							 
							