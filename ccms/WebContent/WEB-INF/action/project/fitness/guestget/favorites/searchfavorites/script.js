
var noticestr = "";
<favorites-rows>
	var title = "${fld:title}";
	if(title.length>20){
		title = title.substring(0, 20)+"...";
	}
	noticestr+="<li onclick='detail(${fld:tuid}, ${fld:type})'>"
			+"<h1>"+title+"</h1>"
			+"<p class='nfoot'><span class='n-name'>${fld:typename}</span>"
			+"<span class='n-date'>最后更新时间：${fld:updated@yyyy-MM-dd HH:mm}</span></p></li>";
</favorites-rows>

$("#favoriteslist").html(noticestr);

function detail(tuid, type){
    location.href = contextPath+"/action/project/fitness/guestget/publish/form?tuid="+tuid+"&types="+type;
}
