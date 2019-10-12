var str="";
<list>
str+='<li  onclick="huixian(\'${fld:code}\',\'${fld:name}\',${fld:mobile})">'
str+='<span>${fld:name}</span>'
	str+='<span>${fld:mobile}</span>'
		str+='</li>'
</list>
$('#custlist').html(str);

function huixian(code,name,mobile){
	$('#customercode').val(code);
	$('#textname').val(name);
	$('#textname1').text(name);
	$('#textmobile1').text(mobile);
	$('.m1').addClass('disNone')
	$('#mm').removeClass('mm');
}

