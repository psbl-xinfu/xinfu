
//列表查看刷新列表，首页弹出不加载列表
if("${fld:type}"=="1"){
	var url="${def:actionroot}/searchnotice";
	ajaxCall(url,{
		method:"get",
		progress:true,
		dataType:"script",
		success:function(){
		}
	});
}