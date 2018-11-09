
var guestnum = [];

cardsalesinfo.total = 0;
cardsalesinfo.xdataArr = [], cardsalesinfo.seriesDataArr = [];
var arr = [];
for(var i =0;i<new Date().getDate();i++){
	var datestr = "";
	if(i<9){
		datestr = '2018-04-0'+(i+1);
	}else{
		datestr = '2018-04-'+(i+1);
	}
	guestnum[i] = 0;
	arr[i] = datestr;
	cardsalesinfo.xdataArr[i] = datestr;
	cardsalesinfo.total++;
}
<ptdefnum-rows>
	for(var i =0;i<arr.length;i++){
		if(arr[i]=="${fld:createdate}"){
			guestnum[i] = ${fld:num};
		}
	}
</ptdefnum-rows>
cardsalesinfo.seriesDataArr = [guestnum];

if( cardsalesinfo.total > 0 ){
	initLineBarCharts("cardsalesDiv", cardsalesinfo, 'bar');
}else{
	$("#cardsalesDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}
