var str=""
<rows>
if("${fld:ptpreparecode}"!=""){
$('#pt').show();
str+='<li code="${fld:code}">'
str+='	<div>'
str+='		<p>'
str+='			${fld:ptname}'
str+='			<span>${fld:created}</span>'
str+='		</p>'
str+='		<p>'
str+='			<span>${fld:ptlevelname}</span>${fld:ptfee}元'
str+='	</p>'
str+='</div>'
str+='</li> '
}else{
	str+='<li code="${fld:code}">'
		str+='	<div>'
		str+='		<p>'
		str+='			'
		str+='			<span>${fld:created}</span>'
		str+='		</p>'
		str+='		<p>'
		str+='			<span></span>'
		str+='	</p>'
		str+='</div>'
		str+='</li> '
}
</rows>
$('#data').html(str);
$('.hetongxqbtn').show();
$('#data li').each(function(){
	$(this).on('click',function(){
		if($(this).hasClass('bg')){
			$(this).removeClass('bg')
		}else{
			$(this).addClass('bg')
		}
	})
	
})


