
var grade = parseInt("${fld:grade}")+1;
var onestr = "<tr><th colspan='"+grade+"'>科目</th>";
for(var i = 1;i<=12;i++){
	onestr+="<th>"+i+"月</th>";
}
onestr+="</th>";
$("#report_subject").html(onestr);

var strtd = "";
var incomecount = 0;
/** 收入目录*/
<income-row>
	incomecount++;
	reportmonthlystr(parseInt("${fld:grade}"), "收入", "${fld:onesubjectname}", "${fld:twosubjectname}", "${fld:threesubjectname}", "${fld:foursubjectname}", "${fld:tdid}", 0);
</income-row>
if(incomecount>0){
	strtd+="<tr><td colspan='"+grade+"'>收入小计：</td>";
	for(var i = 1;i<=12;i++){
		strtd+="<td id='income"+i+"'>0</td>";
	}
	strtd+="</tr>";
}

var spendcount = 0;
/** 支出目录*/
<spend-row>
	spendcount++;
	reportmonthlystr(parseInt("${fld:grade}"), "支出", "${fld:onesubjectname}", "${fld:twosubjectname}", "${fld:threesubjectname}", "${fld:foursubjectname}", "${fld:tdid}", 1);
</spend-row>
if(spendcount>0){
	strtd+="<tr><td colspan='"+grade+"'>支出小计：</td>";
	for(var i = 1;i<=12;i++){
		strtd+="<td id='spend"+i+"'>0</td>";
	}
	strtd+="</tr>";
}
$("#report_monthly").html(strtd);

/** 财务月报*/
<reportmonthly-row>
	$("#${fld:report_subject_id}${fld:report_month}").val("${fld:amonut}");
	$("#span${fld:report_subject_id}${fld:report_month}").html("${fld:amonut}");
</reportmonthly-row>
$(".minput").hide();

/** 1-12月份收入*/
<incomereportmonthly-row>
	$("#income${fld:report_month}").html("${fld:amonut}");
</incomereportmonthly-row>

/** 1-12月份支出*/
<spendreportmonthly-row>
	$("#spend${fld:report_month}").html("${fld:amonut}");
</spendreportmonthly-row>


function reportmonthlystr(grade, type, onesubjectname, twosubjectname, threesubjectname, foursubjectname, tdid, category){
	if(grade==4){
		strtd+="<tr><td nowrap>"+type+"</td><td nowrap>"+onesubjectname+"</td><td nowrap>"+twosubjectname+"</td>"
			+"<td nowrap>"+threesubjectname+"</td><td nowrap>"+foursubjectname+"</td>";
		for(var i = 1;i<=12;i++){
			strtd+="<td class='text-center'><span class='mspan' id='span"+tdid+i+"'>0</span><input class='minput' type='text' size='5' id='"+tdid+i+"' value='0' name='amonut'/>"
			+"<input type='hidden' value='"+tdid+"' name='report_subject_id'/><input type='hidden' value='"+i+"' name='report_month'/>"
			+"<input type='hidden' value='"+category+"' name='category'/></td>";
		}
		strtd+="</tr>";
	}else if(grade==3){
		strtd+="<tr><td nowrap>"+type+"</td><td nowrap>"+twosubjectname+"</td><td nowrap>"+threesubjectname+"</td>"
			+"<td nowrap>"+foursubjectname+"</td>";
		for(var i = 1;i<=12;i++){
			strtd+="<td class='text-center'><span class='mspan' id='span"+tdid+i+"'>0</span><input class='minput' type='text' size='5' id='"+tdid+i+"' value='0' name='amonut'/>"
			+"<input type='hidden' value='"+tdid+"' name='report_subject_id'/><input type='hidden' value='"+i+"' name='report_month'/>"
			+"<input type='hidden' value='"+category+"' name='category'/></td>";
		}
		strtd+="</tr>";
	}else if(grade==2){
		strtd+="<tr><td nowrap>"+type+"</td><td nowrap>"+threesubjectname+"</td><td nowrap>"+foursubjectname+"</td>";
		for(var i = 1;i<=12;i++){
			strtd+="<td class='text-center'><span class='mspan' id='span"+tdid+i+"'>0</span><input class='minput' type='text' size='5' id='"+tdid+i+"' value='0' name='amonut'/>"
			+"<input type='hidden' value='"+tdid+"' name='report_subject_id'/><input type='hidden' value='"+i+"' name='report_month'/>"
			+"<input type='hidden' value='"+category+"' name='category'/></td>";
		}
		strtd+="</tr>";
	}else if(grade==1){
		strtd+="<tr><td nowrap>"+type+"</td><td nowrap>"+foursubjectname+"</td>";
		for(var i = 1;i<=12;i++){
			strtd+="<td class='text-center'><span class='mspan' id='span"+tdid+i+"'>0</span><input class='minput' type='text' size='5' id='"+tdid+i+"' value='0' name='amonut'/>"
			+"<input type='hidden' value='"+tdid+"' name='report_subject_id'/><input type='hidden' value='"+i+"' name='report_month'/>"
			+"<input type='hidden' value='"+category+"' name='category'/></td>";
		}
		strtd+="</tr>";
	}
}

var w = document.documentElement.clientWidth || document.body.clientWidth;

