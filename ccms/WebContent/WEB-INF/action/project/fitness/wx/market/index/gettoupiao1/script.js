var toupiaoFlag=true;

var yitou=0;
<rows>
yitou="${fld:num}";
</rows>
var ketou=$('#votenum').val();
if(ketou!=""){
	if(yitou>=ketou){
		toupiaoFlag=false;
		ccms.dialog.notice("超出每日最大投票");
	}
}



<log> 
	if(toupiaoFlag){
		toupiaoFlag=false;
		ccms.dialog.notice("该参赛者今日已投票");
	}
</log>

if(toupiaoFlag){
	var toupiaoid=$('#toupiaoid').val();
	toupiao(toupiaoid);
}

