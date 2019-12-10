var str=""
	str+='<section>'
		str+='<ul class="list-ul">'
        	<list>
			str+='<li class="list-li">'
	        	str+=' <div class="list">'
	        	str+='        <img src="'+contextPath+'/images/icon_head.png" class="touxiangpic fl">'
	        		
	            		str+=' <div class="content fl"  id="${fld:vc_code}" onclick="getinfo(this,\'${fld:vc_code}\')">'
	        	str+='         <p class="name"><label style="width:100%;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;" title="${fld:officename}">${fld:officename}</label></p>'
	        	str+='       <p class="time"><span>${fld:vc_name}</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>${fld:vc_mobile}</span></p>'
	        	str+='   </div>'
	        	str+=' <a href="tel:${fld:vc_mobile}"> <img src="'+contextPath+'/js/project/fitness/wx/image/tel.png" class="telpic fr"></a>'
	        	str+=' </div>'
	        	str+='<div class="guestbtn" id="guestbtn" onclick="guestbtn(\'${fld:vc_code}\')">查看</div>'
	        str+='</li>'		
	     	  </list>
 			str+='<ul>'
 		str+='</section>'
        	$('.myziyuanlistbody').html(str);
 			
 			gethuadong();
        	