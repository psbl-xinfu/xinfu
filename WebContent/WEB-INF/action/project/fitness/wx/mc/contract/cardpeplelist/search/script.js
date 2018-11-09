var str=""
<list>
str+=' <div class="list"onclick="card(\'${fld:code}\',${fld:num})">'
str+='        <img src="'+contextPath+'${fld:headpic}" class="touxiangpic fl">'
str+='       <div class="content fl">'
str+='         <p class="name">${fld:name}<span>${fld:sex}</span></p>'
str+='       <p class="time">最近跟进：${fld:lasttime}</p>'
str+='   </div>'
str+='  <img src="'+contextPath+'/js/project/fitness/wx/image/banlihetong.png" class="banlihetongpic fr">'
str+=' </div>'
</list>
$('.hetongbklistbody').html(str);