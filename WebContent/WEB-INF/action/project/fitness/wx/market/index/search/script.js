	var str=""
    	<list>
		str+='<div class="sec-details fl " >'
		str+='<img onclick="info(${fld:code})"    style="height:200px" class="user-head"  src='+contextPath+'/action/ccms/attachment/download?id=${fld:tuid}&type=0&t='+new Date().getTime()+'">'
		str+='<label class="user-name"> ${fld:enrollname}</label>'
		str+='			<label class="user-num fr" code="${fld:num}">${fld:num}票</label>'
		str+='	<button class="btn-picket" onclick="touPiaoVer(${fld:code},this)">投票</button>'
		str+='</div>'
    	</list>
    	$('#datas').html(str);