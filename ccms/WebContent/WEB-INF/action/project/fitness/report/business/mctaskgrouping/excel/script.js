if( "" == "${fld:docpath@js}" ){
	ccms.dialog.notice("打印失败",2000);
}else{
	printExcel("${fld:docpath@js}");
}
