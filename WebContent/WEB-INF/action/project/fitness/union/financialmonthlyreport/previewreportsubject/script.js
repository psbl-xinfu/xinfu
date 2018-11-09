var shourutypenum = 0, zhichutypenum = 0;
var str = "<tr><th>门店</th><th>期间</th>";
var count = 0;
//收入
<shouruone-rows>
	count++;
	str+="<th id='${fld:tdid}' colspan='${fld:count}' categorycode='${fld:category}'>${fld:subjectname}</th>";
	shourutypenum+=parseInt('${fld:count}');
</shouruone-rows>
//支出
<zhichuone-rows>
	count++;
	str+="<th id='${fld:tdid}' colspan='${fld:count}' categorycode='${fld:category}'>${fld:subjectname}</th>";
	zhichutypenum+=parseInt('${fld:count}');
</zhichuone-rows>
str+="</tr>";

var count1 = 0;
var str1 = "<tr><th></th><th></th>";
<shourutwo-rows>
	count1++;
	str1+="<th id='${fld:tdid}' colspan='${fld:count}' categorycode='${fld:category}'>${fld:subjectname}</th>";
</shourutwo-rows>
<zhichutwo-rows>
	count1++;
	str1+="<th id='${fld:tdid}' colspan='${fld:count}' categorycode='${fld:category}'>${fld:subjectname}</th>";
</zhichutwo-rows>
str1+="</tr>";

var str2 = "<tr><th></th><th></th>";
var count2 = 0;
<shouruthree-rows>
	count2++;
	str2+="<th id='${fld:tdid}' colspan='${fld:count}' categorycode='${fld:category}'>${fld:subjectname}</th>";
</shouruthree-rows>
<zhichuthree-rows>
	count2++;
	str2+="<th id='${fld:tdid}' colspan='${fld:count}' categorycode='${fld:category}'>${fld:subjectname}</th>";
</zhichuthree-rows>
str2+="</tr>";

var str3 = "<tr><th></th><th></th>";
var count3 = 0;
<shourufour-rows>
	count3++;
	str3+="<th id='${fld:tdid}' colspan='${fld:count}' categorycode='${fld:category}'>${fld:subjectname}</th>";
</shourufour-rows>
<zhichufour-rows>
	count3++;
	str3+="<th id='${fld:tdid}' colspan='${fld:count}' categorycode='${fld:category}'>${fld:subjectname}</th>";
</zhichufour-rows>
str3+="</tr>";

if(count1>0)str+=str1;
if(count2>0)str+=str2;
if(count3>0)str+=str3;

$("#report_subject").append(str);

if(count3==0){
	if(count2==0){
		if(count1>0){
			count = count1;
		}
	}else{
		count = count2;
	}
}else{
	count = count3;
}

<month-rows>
	var report_month = "${fld:report_month}";
	if(parseInt(report_month)<10){
		report_month = "0"+report_month;
	}
	var monthlystr = "<tr><td>${fld:org_name}</td><td>${fld:report_year}"+report_month+"</td>";
	for(var i =0;i<count;i++){
		var thid = $("#report_subject tr:last th").eq(i+2).attr("id");
		var categorycode = $("#report_subject tr:last th").eq(i+2).attr("categorycode");
		var color = "";
		if(categorycode=="1"){
			color = "#ff3a52";
		}
		monthlystr+="<td  data-code='${fld:report_year}${fld:report_month}"+thid+"' data-org='${fld:org_id}' style='color:"+color+";'>0</td>";
	}
	$("#report_monthly").append(monthlystr+"</tr>");
</month-rows>

//财报
<reportmonthly-rows>
	$("td[data-code=${fld:report_year}${fld:report_month}${fld:report_subject_id}][data-org=${fld:org_id}]").html("${fld:amonut}");
</reportmonthly-rows>

//门店个数
$("#orgcount").html("${fld:orgcount}");
//收入
var income = "${fld:income}";
if(income=="")
	income=0;
$("#income").html(income);
//支出
var spending = "${fld:spending}";
if(spending=="")
	spending=0;
$("#spending").html(spending);



var incomeCharts = new chartsClass();
incomeCharts.total = 0;
incomeCharts.xdataArr = [], incomeCharts.seriesDataArr = [];
var subjectArr = [], monthArr = [];
<reportmonthly-rows2>
	if( $.inArray("${fld:report_year}${fld:report_month}", monthArr) < 0 ){
		incomeCharts.xdataArr[incomeCharts.xdataArr.length] = "${fld:report_year}-"+(parseInt("${fld:report_month}")<10?"0":"")+"${fld:report_month}";
		monthArr[monthArr.length] = "${fld:report_year}${fld:report_month}";
	}

	if( $.inArray("${fld:report_subject_id}", subjectArr) < 0 ){
		subjectArr[subjectArr.length] = "${fld:report_subject_id}";
		incomeCharts.legendData[incomeCharts.legendData.length] = "${fld:subject_name@js}";
	}
</reportmonthly-rows2>

for(var j = 0; j < subjectArr.length; j++){
	var dataArr = [];
	for(var i = 0; i < monthArr.length; i++){
		var yearmonth = monthArr[i];
		var amount = 0;
		$("td[data-code="+yearmonth+subjectArr[j]+"]").each(function(idx,ele){
			if( "" != $(this).html() && !isNaN($(this).html()) ){
				if( $(this).prevAll().length >= $(this).parent().find("td").length - 2 ){
					amount = parseFloat(amount) - parseFloat($(this).html());
				}else{
					amount = parseFloat(amount) + parseFloat($(this).html());
				}
			}
		});
		dataArr[i] = amount;
	}
	incomeCharts.seriesDataArr[j] = dataArr;
}

incomeCharts.total = subjectArr.length;
if( incomeCharts.total > 0 ){
	initLineBarCharts("incomeDiv", incomeCharts, "bar");
}else{
	$("#incomeDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}
