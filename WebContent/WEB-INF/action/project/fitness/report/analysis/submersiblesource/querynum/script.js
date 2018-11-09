
var introducenum=0, wbexpandnum=0, count=0, yyvisitnum=0, tyknum=0;
var arrdate = new Array();
var arrintroduce = new Array();
var arrwbexpand = new Array();
var arrtyk = new Array();
<rows>
	introducenum+=parseFloat("${fld:introducenum}");
	wbexpandnum+=parseFloat("${fld:wbexpandnum}");
	tyknum+=parseFloat("${fld:tyknum}");
	
	arrdate[count]="${fld:created}";
	arrintroduce[count]=parseFloat("${fld:introducenum}");
	arrwbexpand[count]=parseFloat("${fld:wbexpandnum}");
	arrtyk[count]=parseFloat("${fld:tyknum}");
	count++;
</rows>
$("#introducenum").html(introducenum);
$("#wbexpandnum").html(wbexpandnum);
$("#tyknum").html(tyknum);



var chart = echarts.init(document.getElementById("main")); //找到对应画图区域id
var option = {
    color:['#40C647', '#21a79d','#ff2d47'],
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
            name: '外部拓展数量',
            type: 'line',
            data: arrwbexpand
        },{
            name: '客户转介绍数量',
            type: 'line',
            data: arrintroduce
        },{
            name: '线上拓展数量',
            type: 'line',
            data: arrtyk
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

    color:['#40C647', '#21a79d','#ff2d47'],
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
                {value:wbexpandnum, name:'外部拓展数量'},
                {value:introducenum, name:'客户转介绍数量'},
                {value:tyknum, name:'线上拓展数量'}
            ]
        }
    ]
};
// 为echarts对象加载数据
myChart.setOption(myOption);
