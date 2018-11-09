
var noticestr = "", noticecolor = "", unreadnotice = 0;
<notice-rows>
	if(${fld:level}==1){
		noticecolor = "icon-emergency";
	}else if(${fld:level}==2){
		noticecolor = "icon-follow";
	}else{
		noticecolor = "";
	}
	unreadnotice+=${fld:unreadnotice};
	var title = "${fld:title}";
	if(title.length>20){
		title = title.substring(0, 20)+"...";
	}
	noticestr+="<li onclick='detailnotice(${fld:tuid})'><span class='"+noticecolor+" tag'></span>"
			+"<h1>"+title+"</h1>"
			+"<p class='nfoot'><span class='n-name'>${fld:createdby}</span>"
			+"<span class='n-date'>${fld:created@yyyy-MM-dd HH:mm}</span></p></li>";
</notice-rows>

$("#noticeList").html(noticestr);
$("#unreadnotice").html(unreadnotice);

function detailnotice(tuid){
	var url="${def:actionroot}/searchnoticedetail?tuid="+tuid+"&type=1";
	ajaxCall(url,{
		method:"get",
		progress:true,
		dataType:"script",
		success:function(){
		}
	});
}
