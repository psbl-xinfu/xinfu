if("${fld:status}"==1){
	toupiaoFlag=false;
	ccms.dialog.notice("投票时间已截止");
}else{
	if("${fld:votetype}"==0){//每日均可投票
		touPiaoVer1(0);
	}else{//一次性投票
		touPiaoVer1(1);
	}
	
}



function touPiaoVer1(num){
	var toupiaoid=$('#toupiaoid').val();
	var wxuserid=$('#wxuserid').val();
	if(num==0){
		getAjaxCall("/action/project/fitness/wx/market/index/gettoupiao1?toupiaoid="+toupiaoid+"&wxuserid="+wxuserid,false,function(){
		});
	}else{
		getAjaxCall("/action/project/fitness/wx/market/index/gettoupiao2?toupiaoid="+toupiaoid+"&wxuserid="+wxuserid,false,function(){
		});
	}
}
