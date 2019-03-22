	var str=""
        	<list>
        	str+=' <div class="list">'
        	str+='        <img src="'+contextPath+'/images/icon_head.png" class="touxiangpic fl">'
        		
               	if("${fld:num}"==1){
            		str+=' <div class="content fl"onclick="getinfo(\'${fld:code}\')">'
            	}else{
            		str+=' <div class="content fl" onclick="qiang(\'${fld:code}\')">'
            	}
        		
        	str+='         <p class="name"><label style="width:40%;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;" title="${fld:name}">${fld:name}</label><span>${fld:sex}</span><span>${fld:mobile}</span></p>'
        	str+='       <p class="time">最近跟进：${fld:lasttime}</p>'
        	str+='   </div>'
        	if("${fld:num}"==1){
        		str+=' <a href="tel:${fld:mobile}"> <img src="'+contextPath+'/js/project/fitness/wx/image/tel.png" class="telpic fr"></a>'
        	}else{
        		str+='  <img onclick="qiang(\'${fld:code}\')" src="'+contextPath+'/js/project/fitness/wx/image/qiang.png" class="qiangpic fr">'
        	}
        	str+=' </div>'
        	</list>
        	$('.myziyuanlistbody').html(str);
        	
