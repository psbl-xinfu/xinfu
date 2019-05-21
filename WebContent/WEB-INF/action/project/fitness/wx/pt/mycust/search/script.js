// modified by leo 190228我的会员修正筛选空白问题
//$('.list_a').remove();
$('.list').remove();
<list>
	appendCust('${fld:code}','${fld:name}','${fld:sex}','${fld:mobile}','${fld:lasttime}','${fld:headpic}');
	
</list>

function appendCust(code,name,sex,mobile,lasttime,headpic) //增加会员
{
	html="<div class='list' code="+code+">"+
		    '<img src="${def:context}'+headpic+'" class="touxiangpic fl">'+
		   
			"<a class='list_a' href='${def:context}/action/project/fitness/wx/pt/mycust/sijiaohuiyuanmsg?customercode="+code+"&type=pt'>"+
		    "<div class='content fl'>"+
		        "<p class='name'><label style='width:40%;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;' title='"+name+"'>"+name+"</label><span>"+sex+"</span><span>"+mobile+"</span></p>"+
		        "<p class='time'>最近跟进："+lasttime+"</p>"+
		    "</div>"+
		    '</a>'+
		   '<a href="tel:'+mobile+'">  <img src="${def:context}/js/project/fitness/wx/image/tel.png" class="telpic fr" ></a>'+
		'</div>'
	
	$('.myhuiyuanlistbody').append(html);
}