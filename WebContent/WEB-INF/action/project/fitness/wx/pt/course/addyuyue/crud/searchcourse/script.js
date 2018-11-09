var str="";
<list>
str+='<li  onclick="huixian(\'${fld:code}\'	,\'${fld:ptlevelname}\',\'${fld:status}\',${fld:ptleftcount})">'
str+='<span>${fld:ptlevelname}</span>'
str+='<span>剩余${fld:ptleftcount}课时</span>'
str+='<span>${fld:status}</span>'
str+='</li>'
</list>
$('#courselist').html(str);
function huixian(code,name,status,ptleftcount){
	$('#textcourse').val(name);
	$('#ptrestcode').val(code);
	$('.m1').addClass('disNone')
	$('#mm').removeClass('mm');
	$('#corsestatus').val(status);
	$('#ptleftcount').val(ptleftcount);
	getPtrest();
}
function getPtrest(){
	var customercode = $("#customercode").val()
    	getAjaxCall("/action/project/fitness/wx/pt/course/addyuyue/crud/getptrest?customercode="+customercode+"&ptrestcode="+$('#ptrestcode').val(),false);
}