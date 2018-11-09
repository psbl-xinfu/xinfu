if( Number(${fld:class_num}) > 0 ){
	ccms.dialog.notice("当前资源已有${fld:class_num}个课时在使用，不允许删除！");
}else{
	$Dialog().confirm("确定要删除吗?",function() {
		ccms.qcloud.deleteVideo("${fld:fileid}",function(){
			searchObj.searchData(1);
		});
	});
}