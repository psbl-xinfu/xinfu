var str=""
<rows>
str+="	<div>"
str+="				<span>${fld:created}</span>"
str+="				<p>"
str+="					<button onclick='see(${fld:code})'>查看</button>"
str+="				</p>"
str+="			</div>"
</rows>
$('.footer').html(str)


<info>
$('#body_fat').text("${fld:body_fat}");
$('#weight').text("${fld:weight}");
$('#lung_capacity').text("${fld:lung_capacity}");
$('#weight_index').text("${fld:weight_index}");
$('#static_heart').text("${fld:static_heart}");
$('#muscle').text("${fld:muscle}");
</info>

