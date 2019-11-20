	var str=""
        	<list>
        	str+=' <div class="list">'
        	str+='        <img src="'+contextPath+'/images/icon_head.png" class="touxiangpic fl">'
        		
            		str+=' <div class="content fl"onclick="getinfo(\'${fld:code}\')">'
        	str+='         <p class="name"><label style="width:100%;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;" title="${fld:officename}">${fld:officename}</label></p>'
        	str+='       <p class="time"><span>${fld:vc_name}</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>${fld:mobile}</span></p>'
        	str+='   </div>'
        	str+=' <a href="tel:${fld:mobile}"> <img src="'+contextPath+'/js/project/fitness/wx/image/tel.png" class="telpic fr"></a>'
        	str+=' </div>'
        	</list>
        	$('.myziyuanlistbody').html(str);
        	
