
var msvisitnum=0, tjguestnum=0, count=0, yyvisitnum=0;
var arrdate = new Array();
var arrms = new Array();
var arryy = new Array();
var arrkh = new Array();
<rows>
	msvisitnum+=parseFloat("${fld:msvisitnum}");
	tjguestnum+=parseFloat("${fld:tjguestnum}");
	yyvisitnum+=parseFloat("${fld:yyvisitnum}");

	arrdate[count]="${fld:created}";
	arrms[count]=parseFloat("${fld:msvisitnum}");
	arryy[count]=parseFloat("${fld:yyvisitnum}");
	arrkh[count]=parseFloat("${fld:tjguestnum}");
	count++;
</rows>
$("#msvisitnum").html(msvisitnum);
$("#tjguestnum").html(tjguestnum);
$("#yyvisitnum").html(yyvisitnum);



var chart = echarts.init(document.getElementById("main")); //找到对应画图区域id
var option = {
    color:['#6EC685', '#21A79D','#FF2D47'],
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
            name: '陌生到访',
            type: 'line',
            data: arrms
        },{
            name: '电话邀约到访',
            type: 'line',
            data: arryy
        },{
            name: '客户转介绍到访',
            type: 'line',
            data: arrkh
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

    color:['#6EC685', '#21A79D','#FF2D47'],
   
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
                {value:msvisitnum, name:'陌生到访'},
                {value:yyvisitnum, name:'电话邀约到访'},
                {value:tjguestnum, name:'客户转介绍到访'}
            ]
        }
    ]
};
// 为echarts对象加载数据
myChart.setOption(myOption);