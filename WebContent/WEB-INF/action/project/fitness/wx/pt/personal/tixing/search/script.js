    	var str=""
       <rows>
    	if("${fld:custype}"=="1"){
    		str+=' <div class="list"onclick="custinfo(\'${fld:customercode}\')">'
    		str+=' <div class="content fl" style="">'
    		 str+='  <p class="name">${fld:cname}<span>${fld:status}</span></p>'
    	}else{
    		str+=' <div class="list"onclick="gustinfo(\'${fld:customercode}\')">'
    		str+=' <div class="content fl" style="">'
    		str+='  <p class="name">${fld:cname}<span>${fld:status}</span></p>'
    	}
    	str+=' <p class="time">${fld:nexttime}-${fld:nexttime1}</p>'
    	str+='  </div>'
    	str+=' <a href="#"><img src="${def:context}/js/project/fitness/wx/image/select_jiantou.png" class="telpic fr"></a>'
    	str+=' </div>'
       </rows>
    	$('.myyuyuelistbody').html(str);