
$("#mcstaffDiv").html("");
/** 性别 */
var seriesJson1 = {
	name:'性别',
	type:'pie',
	selectedMode: 'single',
	radius: [0, '50%'],
	label: {
		normal: {
			position: 'inner'
		}
	},
	labelLine: {
		normal: {
			show: false
		}
	},
	data: [
	   	{value: ${fld:unkownnum}, name: '未知', selected: true},
		{value: ${fld:femalenum}, name: '女'},
		{value: ${fld:malenum}, name: '男'}
	]
};
/** 会籍分析 */
var seriesJson2 = {
	name:'会籍分析',
	type:'pie',
	selectedMode: 'single',
	radius: ['60%', '75%'],
	data: [
		{value: ${fld:guestnum}, name: '潜在资源'},
		{value: ${fld:custnum}, name: '会员'},
		{value: ${fld:expirecustnum}, name: '过期会员'},
	]
};
if(${fld:unkownnum}==0&&${fld:femalenum}==0&&${fld:malenum}==0&&${fld:guestnum}==0&&${fld:custnum}==0&&${fld:expirecustnum}==0){
	$("#mcstaffDiv,#mcstaffDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}else{
	mcPic.createCharts([seriesJson1, seriesJson2]);
	var seriesArr = [
	        		{value: ${fld:malenum}, name: '男'},
	        		{value: ${fld:femalenum}, name: '女'},
	         	   	{value: ${fld:unkownnum}, name: '未知'},
	        		{value: ${fld:guestnum}, name: '潜在资源'},
	        		{value: ${fld:custnum}, name: '会员'},
	        		{value: ${fld:expirecustnum}, name: '过期会员'}
	            ];
	//列表
	pielist("mcstaff", seriesArr);
}
