var str="";
    	<list>
    	
    	if("${fld:num}"==0){
    		str+='<div class="myself">'
    		str+='<p class="time" id="times">${fld:sendtime@yyyy-MM-dd  hh:mm:ss}</p>'
    		str+='<div class="liaotiancontent fl">'
    		str+='<img   src="'+contextPath+'${fld:headpic}" class="liaotiantouxiang">'
    		str+='<div class="liaotiantxt">'
    		str+='  ${fld:content}'
    		str+='<img   src="'+contextPath+'/js/project/fitness/wx/image/liaotianimg1.png" class="liaotianjiaohui">'
    		str+='</div>'
    		str+='</div>'
    		str+='   </div>'
    			
    			
    	}else{	
       	str+='<div class="yourself">'
            	str+='<p class="time" id="times">${fld:sendtime@yyyy-MM-dd  hh:mm:ss}</p>'
            	str+='<div class="liaotiancontent fr">'
            	str+='<div class="liaotiantxt">${fld:content}'
                str+='<img    src="'+contextPath+'/js/project/fitness/wx/image/liaotianimg2.png" class="liaotianjiaohui" style="right:-9px">'
                str+=' </div>'
                str+='<img   src="'+contextPath+'${fld:headpic}" class="liaotiantouxiang">'
                str+='</div>'
                str+='</div>'
    	}
    	</list>
        $('.huijiliaotiancontent').html(str);
        
        if(flag){
        	sc();
        }
