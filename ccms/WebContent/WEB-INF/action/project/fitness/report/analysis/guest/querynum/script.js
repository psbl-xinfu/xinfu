
var arrdate = new Array();
var guestnum = new Array();
var dealnum = new Array();
var visitnum = new Array();
var yynum = new Array();
var count = 0, gnum = 0, dnum = 0, vnum = 0, ynum = 0;
<rows>
arrdate[count]="${fld:created}";
guestnum[count]="${fld:guestnum}";
dealnum[count]="${fld:dealnum}";
visitnum[count]="${fld:visitnum}";
yynum[count]="${fld:commnum}";
count++;
gnum+=parseInt("${fld:guestnum}");//资源获取量
dnum+=parseInt("${fld:dealnum}");//成交量
vnum+=parseInt("${fld:visitnum}");//到访量
ynum+=parseInt("${fld:commnum}");//邀约量
</rows>
$("#guestnum").html(gnum);
$("#dealnum").html(dnum);
$("#visitnum").html(vnum);
$("#yynum").html(ynum);

var chart = echarts.init(document.getElementById("main")); //找到对应画图区域id
	    var option = {
	    backgroundColor: '#2d3740',
	    tooltip: {
	        trigger: 'axis',
	        axisPointer: {
	            type: 'shadow'
	        }
	    },
	    legend: {
	        data: ['资源获取数量', '邀约数量', '到访数量', '成交数量'],
	        align: 'right',
	        right: 10,
	        textStyle: {
	            color: "#fff"
	        },
	        itemWidth: 10,
	        itemHeight: 10,
	        itemGap: 35
	    },
	    grid: {
	        left: '3%',
	        right: '4%',
	        bottom: '3%',
	        containLabel: true
	    },
	    xAxis: [{
	        type: 'category',
	        data: arrdate,
	        axisLine: {
	            show: true,
	            lineStyle: {
	                color: "#fff",
	                width: 1,
	                type: "solid"
	            }
	        },
	        axisTick: {
	            show: false,
	        },
	        axisLabel: {
	            show: true,
	            textStyle: {
	                color: "#fff",
	            }
	        },
	    }],
	    yAxis: [{
	        type: 'value',
	        axisLabel: {
	            formatter: '{value} '
	        },
	        axisTick: {
	            show: false,
	        },
	        axisLine: {
	            show: true,
	            lineStyle: {
	                color: "#fff",
	                width: 1,
	                type: "solid"
	            },
	        },
	        
	        splitLine: {
	            show: false
	        }
	    }],
	    series: [{
	        name: '资源获取数量',
	        type: 'bar',
	        data: guestnum,
	        barWidth: 10, //柱子宽度
	        barGap: 1, //柱子之间间距
	        itemStyle: {
	            normal: {
	                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
	                    offset: 0,
	                    color: '#6EC685'
	                }, {
	                    offset: 1,
	                    color: '#6EC685'
	                }]),
	                opacity: 1,
	            }
	        }
	    }, {
	        name: '邀约数量',
	        type: 'bar',
	        data: yynum,
	        barWidth: 10,
	        barGap: 1,
	        itemStyle: {
	            normal: {
	                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
	                    offset: 0,
	                    color: '#21A79D'
	                }, {
	                    offset: 1,
	                    color: '#21A79D'
	                }]),
	                opacity: 1,
	            }
	        }
	    }, {
	        name: '到访数量',
	        type: 'bar',
	        data: visitnum,
	        barWidth: 10,
	        barGap: 1,
	        itemStyle: {
	            normal: {
	                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
	                    offset: 0,
	                    color: '#AC6EC6'
	                }, {
	                    offset: 1,
	                    color: '#AC6EC6'
	                }]),
	                opacity: 1,
	            }
	        }
	    }, {
	        name: '成交数量',
	        type: 'bar',
	        data: dealnum,
	        barWidth: 10,
	        barGap: 1,
	        itemStyle: {
	            normal: {
	                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
	                    offset: 0,
	                    color: '#C3C66E'
	                }, {
	                    offset: 1,
	                    color: '#C3C66E'
	                }]),
	                opacity: 1,
	            }
	        }
	    }]
	};
   chart.setOption(option);