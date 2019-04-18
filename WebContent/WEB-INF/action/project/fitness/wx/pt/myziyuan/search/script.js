// modified by leo 190228修正我的资源筛选空白问题
//$('.list_a').remove();
$('.list').remove();
<rows>
appendCust('${fld:code}','${fld:name}','${fld:sex}','${fld:mobile}','${fld:lasttime}','${fld:headpic}');
	
</rows>

function appendCust(code,name,sex,mobile,lasttime,headpic) //增加会员
{
	
	html=   "<div class='list' code="+code+">"+
    		'<img src="${def:context}'+headpic+'" class="touxiangpic fl">'+
			"<a class='list_a' href='${def:context}/action/project/fitness/wx/pt/mycust/sijiaohuiyuanmsg?customercode="+code+"&type='>"+
		    "<div class='content fl'>"+
		        "<p class='name'><label style='width:40%;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;' title='#"+name+"#'>"+name+"</label><span>"+sex+"</span><span>"+mobile+"</span></p>"+
		        "<p class='time'>最近跟进："+lasttime+"</p>"+
		    "</div>"+
		    '</a>'+
		    "<a href='tel:${fld:mobile}' > <img src='${def:context}/js/project/fitness/wx/image/tel.png' class='telpic fr'></a>"+
		'</div>'
	
	$('.myziyuanlistbody').append(html);
}