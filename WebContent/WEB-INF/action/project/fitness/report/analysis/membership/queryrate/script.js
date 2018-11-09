
var msdealnum = 0, msvisitnum=0, tjdealnum=0, tjguestnum=0, count=0, yydealnum=0, yyvisitnum=0;
var arrdate = new Array();
var arrms = new Array();
var arryy = new Array();
var arrkh = new Array();
<rows>
	msdealnum+=parseFloat("${fld:msdealnum}");
	msvisitnum+=parseFloat("${fld:msvisitnum}");
	tjdealnum+=parseFloat("${fld:tjdealnum}");
	tjguestnum+=parseFloat("${fld:tjguestnum}");
	yydealnum+=parseFloat("${fld:yydealnum}");
	yyvisitnum+=parseFloat("${fld:yyvisitnum}");

	arrdate[count]="${fld:created}";
	arrms[count]=(0 == parseFloat("${fld:msvisitnum}") ? 0 : parseFloat("${fld:msdealnum}")/parseFloat("${fld:msvisitnum}")*100).toFixed(0);
	arryy[count]=(0 == parseFloat("${fld:yyvisitnum}") ? 0 : parseFloat("${fld:yydealnum}")/parseFloat("${fld:yyvisitnum}")*100).toFixed(0);;
	arrkh[count]=(0 == parseFloat("${fld:tjguestnum}") ? 0 : parseFloat("${fld:tjdealnum}")/parseFloat("${fld:tjguestnum}")*100).toFixed(0);
	count++;
</rows>

//陌生到访成交率
var msrate = (0 == msvisitnum ? 0 : msdealnum/msvisitnum*100).toFixed(2);	/** 成交率 */
judgePercentage("msrate", msrate);

//邀约到访成交率
var yyrate = (0 == yyvisitnum ? 0 : yydealnum/yyvisitnum*100).toFixed(2);	/** 成交率 */
judgePercentage("yyrate", yyrate);

//客户转介绍到访成交率
var guestrate = (0 == tjguestnum ? 0 : tjdealnum/tjguestnum*100).toFixed(2);	/** 成交率 */
judgePercentage("guestrate", guestrate);

//
var zongdeal = msdealnum+tjdealnum;
var zongvisit = msvisitnum+tjguestnum;
var zongrate = (0 == zongvisit ? 0 : zongdeal/zongvisit*100).toFixed(2);	/** 成交率 */
judgePercentage("zongrate", zongrate);


function judgePercentage(id, percentage){
	if(percentage>100){percentage = 100;}
	if(percentage<-100){percentage = -100;}
	$("#"+id).text(Number(percentage).toFixed(2)+"%");
}

var chart = echarts.init(document.getElementById("main")); //找到对应画图区域id
var option = {
	    color:['#00FFFF','#ff2d47', 'yellow'],
	    tooltip: {
	        trigger: 'axis'
	    },
	    grid: {
	        left: '0%',
	        right: '2%',
	        bottom: '0%',
	        containLabel: true
	    },
	    xAxis: {
	        type: 'category',
	        boundaryGap: false,
	        data: arrdate,
            axisLine: {
                lineStyle: {
                    color: '#FFF'
                }
            },
            axisLabel: {
                textStyle: {
                    color: '#FFF'
                }
            }
	    },
	    yAxis: {
	        x: 'center',
	        type: 'value',
            axisLine: {
                lineStyle: {
                    color: '#FFF'
                }
            },
            axisLabel: {
                textStyle: {
                    color: '#FFF'
                }
            },splitLine: {
                show: false
            }
	    },
	    series: [
	        {
	            name: '转介绍成交率',
	            type: 'line',
	            data: arrkh
	        },{
	            name: '邀约到访成交率',
	            type: 'line',
	            data: arryy
	        },{
	            name: '陌生到访成交率',
	            type: 'line',
	            data: arrms
	        }
	    ]
};
//加载数据
chart.setOption(option);

// 应用饼图区域
var myChart = echarts.init(document.getElementById("content"));
var myOption = {
    tooltip : {
        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
	},
    color:['#00FFFF','#ff2d47', 'yellow'],
    calculable : true,
    series : [
        {
          
            type:'pie',
            radius : '55%',
            center: ['40%', '60%'],
            // 设置标题直接带百分比
            itemStyle: {
                normal:{
                    label:{
                        show: true,
                
                    },
                 
                }
            },
            // 设置字体
          
            data:[
                {value:guestrate, name:'转介绍成交率'},
                {value:234, name:'邀约到访成交率'},
                {value:msrate, name:'陌生到访成交率'}
                
            ]
        }
    ]
};
// 为echarts对象加载数据
myChart.setOption(myOption);
