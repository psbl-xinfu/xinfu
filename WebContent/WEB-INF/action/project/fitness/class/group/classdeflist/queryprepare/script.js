
$("#monitor>li>nav").html("");
<rows>
	var _date = "${fld:classdate}";
	var pobj = $("#monitor p[code=" + _date + "]").next();
	var htmlstr="";
	htmlstr+="<li style='background-color: #${fld:class_bgcolor}'>";
	if("${fld:status}"=="1"){
		htmlstr+="<img class='img-left' src='${def:context}/js/project/fitness/image/SVG/btn/yifabu.svg' title='已发布'>";
	}
	if("${fld:status}"=="2"){
		htmlstr+="<img class='img-right tcimg' src='${def:context}/js/project/fitness/image/SVG/btn/gouxuan.svg' title='未发布' id='${fld:code@js}img'>";
	}
	htmlstr+="<header>${fld:class_name@js}</header>";
	htmlstr+="<p><span>${fld:classtime}~${fld:endtime}</span></p>"
				+"<p class='toWidthAll'><span>${fld:name@js}</span><span>${fld:classroom_name@js}</span>"
				+"</p><p>${fld:nowcount}/${fld:limitcount}</p><nav class='hover-show'><li>"
				+"		<img src='${def:context}/js/project/fitness/image/SVG/table/icon_chakan.svg' alt='' onclick='detail(${fld:code@js})' title='详情'>"
				+"	</li><li>"
				+"		<img src='${def:context}/js/project/fitness/image/SVG/table/icon_xiugai.svg' onclick='editdef(${fld:code@js})' alt='' title='修改'>"
				+"	</li><li>"
				+"		<img src='${def:context}/js/project/fitness/image/SVG/table/icon_shanchu.svg' alt='' onclick='deleteclassdef(${fld:code@js}, ${fld:status})' title='删除'>"
				+"	</li><li>"
				+"		<img src='${def:context}/js/project/fitness/image/SVG/table/icon_kaoqin.svg' alt='' onclick='classkqcode(${fld:code@js})' title='考勤'>"
				+"	</li><li>"
				+"		<img src='${def:context}/js/project/fitness/image/SVG/table/icon_fuzhi.svg' alt='' onclick='coptclassdef(${fld:code@js})' title='课程复制'>"
				+"	</li><li>"
				+"		<img src='${def:context}/js/project/fitness/image/SVG/table/icon_dengji.svg' alt='' onclick='personcount(${fld:code@js})' title='课程人数'>"
				+"	</li>";
				if("${fld:status}"=="2"){
					htmlstr+="<li><img src='${def:context}/js/project/fitness/image/SVG/table/icon_piliangshanchu.svg' alt='' onclick='consort(${fld:cdcode@js}, \"${fld:class_name@js}\")' title='删除未发布同类'></li>";
					htmlstr+="<input type='checkbox' value='${fld:code@js}' name='classdefchk'/>";
				}
				htmlstr+="</nav></li>";
				pobj.append(htmlstr);
</rows>
ccms.util.renderCheckbox("classdefchk");
$(".tcimg").hide();
$("input[name=classdefchk]").unbind().on("ifClicked",function(){   
	if($(this).prop("checked")){
		$("#"+$(this).val()+"img").hide();
	}else{
		$("#"+$(this).val()+"img").show();
	}
});


