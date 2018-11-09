if( "" == "${fld:docpath@js}" ){
	ccms.dialog.notice("打印失败", 2000);
}else{
	console.log("${fld:docpath@js}");
	printdoc("${fld:docpath@js}");
}
