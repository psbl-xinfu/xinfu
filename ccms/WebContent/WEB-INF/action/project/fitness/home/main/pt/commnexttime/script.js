//今日跟进提醒
var commstr = "", count = 0;
<commnexttime-rows>
	count++;
	var strcolor = "", imgid = "";
	if(count<4){
		strcolor = 'color-'+count;
	}
	if("${fld:imgid}"==""){
		imgid = "${def:context}/js/project/fitness/image/SVG/50X50.svg";
	}else{
		imgid = "${def:context}/action/project/fitness/util/attachment/download?tuid=${fld:imgid}&type=1";
	}
	commstr += "<tr><td>"+count+"</td><td><img src='"+imgid+"' alt=''>"
			+"</td><td class='"+strcolor+"'>${fld:name@js}</td><td>${fld:mobile@js}</td>"
			+"<td>${fld:nexttime@yyyy-MM-dd HH:mm}</td><td>${fld:remark@js}</td></tr>";

</commnexttime-rows>
$("#commcount").html(count);
$("#commnexttime").html(commstr);

var resstr = "", rescount = 0;;
//潜在资源
<res-rows>
	rescount++;
	var strcolor = "", imgid = "";
	if(rescount==1)strcolor = 'r-i-one';
	if(rescount==2)strcolor = 'r-i-two';
	if(rescount==3)strcolor = 'r-i-three';
	
	if("${fld:imgid}"==""){
		imgid = "${def:context}/js/project/fitness/image/SVG/50X50.svg";
	}else{
		imgid = "${def:context}/action/project/fitness/util/attachment/download?tuid=${fld:imgid}&type=1";
	}
	resstr+="<article class='"+strcolor+"'><span class='rank'>"+rescount+"</span>"
		+"<img src='"+imgid+"' alt=''>"
		+"<span class='name'>${fld:name@js}</span><span class='count'>${fld:mobile@js}</span></article>";
</res-rows>
$("#rescount,#testFinishNum").html(rescount);
$("#reshtml").html(resstr);
