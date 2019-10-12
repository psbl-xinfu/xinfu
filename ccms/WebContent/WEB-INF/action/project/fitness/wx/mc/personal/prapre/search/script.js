    	var str=""
       <rows>
    	str+=' <div class="list">'
    	str+=' <div class="content fl" onclick="getinfo(\'${fld:code}\',${fld:commcode},\'${fld:status}\')">'
    	str+='  <p class="name">${fld:name}<span>${fld:status}</span></p>'
    	str+=' <p class="time">${fld:preparetime}-${fld:preparetime1}</p>'
    	str+='  </div>'
    	str+='  <img src="${def:context}/js/project/fitness/wx/image/select_jiantou.png" class="telpic fr">'
    	str+=' </div>'
       </rows>
    	$('.myyuyuelistbody').html(str);