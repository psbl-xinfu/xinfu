var flag=false
<rows>
flag=true;
	document.addForm.cus_code.value="${fld:code}";
</rows>
if(!flag){
		alert("没有此会员");
		if($('#cus_code')!=''){
			$('#recommend').val($('#in_recommend_name').val());
		}else{
			$('#recommend').val('');
		}
}
