var str="";
var code="";
var index=0;
<rows>
if("${fld:trainplancode}"!=code){
	index++;
	str+='<li class="con-details"  onclick="getInfo(\'${fld:tcode}\',\'${fld:pcode}\',\'${fld:customercode}\',\'${fld:preparedate}\')">'
	str+='<span class="det-time">${fld:created}</span>'
	str+='	<div class="det-sec">'
	str+='		<label class="det-title">动作'+index+'：</label>'
	str+='		<label class="det-desc">${fld:train_part}，${fld:apparatus}，${fld:actions}</label>'
	str+='		<label class="det-d">训练细节：${fld:train_detail_part}</label>'
	str+='		<label class="det-d">组${fld:groups}；重量${fld:weight}kg; 数量${fld:num}；</label>'
	str+='		<label class="det-d-1">${fld:preparetime} ${fld:ptlevelname} 教练 ${fld:name}</label>'
	if("${fld:status}"==2){
		str+='		<span class="det-status" code="2">已执行</span>'
	}else{
		str+='		<span class="det-status no-s" code="1">未执行</span>'
	}
	str+='	</div>'
	str+='</li>'
		
	code="${fld:trainplancode}";
}
</rows>
$('.con-list').html(str);


