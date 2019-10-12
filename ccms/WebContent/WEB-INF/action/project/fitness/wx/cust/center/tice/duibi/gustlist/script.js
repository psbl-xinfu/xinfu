var str=""
<rows>
	str+='<li>'
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


