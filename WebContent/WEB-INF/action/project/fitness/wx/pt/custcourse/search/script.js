// modified by leo 190228我的会员修正筛选空白问题
//$('.list_a').remove();
$('.list').remove();
<list>
	appendCust('${fld:code}','${fld:name}','${fld:pttotalcount}','${fld:ptlevelname}','${fld:ptleftcount}','${fld:headpic}');
	
</list>

function appendCust(code,name,pttotalcount,ptlevelname,ptleftcount,headpic) //增加会员
{
	html="<div class='list' code="+code+">"+
		    '<img src="${def:context}'+headpic+'" class="touxiangpic fl">'+
		   
			"<a class='list_a' >"+
		    "<div class='content fl'>"+
		        "<p class='cust'><label style='width:40%;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;' title='"+name+"'>"+name+"</label><span>课程："+ptlevelname+"</span></p>"+
		        "<p class='custcount'>购买课时："+pttotalcount+"节</p>"+
		        "<p class='custcount'>剩余课时："+ptleftcount+"节</p>"+
		    "</div>"+
		    '</a>'+
		'</div>'
	
	$('.myhuiyuanlistbody').append(html);
}