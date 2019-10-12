
var str = "", str1 = "";
<rows>
	//判断是否是群主   群主显示第一个
	if("${fld:leader}"=="${fld:pkvalue}"){
		str="<li><img src='"+contextPath + "/action/project/fitness/util/attachment/download?tuid=${fld:imgid}&type=1'"
					+" onerror=javascript:this.src='${def:context}/js/project/fitness/image/SVG/50X50.svg' /></li>"+str;
	}else{
		str+="<li><img src='"+contextPath + "/action/project/fitness/util/attachment/download?tuid=${fld:imgid}&type=1'"
		+" onerror=javascript:this.src='${def:context}/js/project/fitness/image/SVG/50X50.svg' /></li>";
	}
	//群主不显示在可移除列表
	if("${fld:leader}"!="${fld:pkvalue}"){
		str1+="<li class='member'><div class='lt'><div class='head_pic'>"
				+"<img src='"+contextPath + "/action/project/fitness/util/attachment/download?tuid=${fld:imgid}&type=1'"
				+" onerror=javascript:this.src='${def:context}/js/project/fitness/image/SVG/50X50.svg' />"
				+"</div><div class='name'>${fld:name}</div></div>"
				+"<div class='right'>";
		//判断当前登录人是否是群主
		if($("#weixinlogin").val()==$("#weixin_userid").val()){
			str1+="<span class='remove' onclick='delmember(${fld:tuid}, ${fld:org_id})'>移除</span>";
		}
		str1+="<span class='check-mark'><input type='radio' name='membervalue' value='${fld:pkvalue}' /></span></div></li>";
	}
</rows>
str+="<li id='more'><img src='${def:context}/js/project/fitness/wx/image/team/more.png' /></li>";
$("#memberimg").html(str);
$(".member_list").html(str1);

ccms.util.renderRadio("membervalue");

//加载隐藏转让radio和转让按钮
$('#tean_member .check-mark').css('display','none');
$("#transfer").hide();

// 更多
$('#more').click(function () {
    $('#tean_member .check-mark').css('display','none');
    $('#tean_member').css('display','block');
    $("#transfer").hide();
})
//转让群主
$('.change').click(function () {
    $('#tean_member .remove').css('display','none');
	$('#tean_member').css('display','block');
	//显示转让隐藏radio和转让按钮
    $('#tean_member .check-mark').css('display','block');
    $("#transfer").show();
})
//移除
function delmember(tuid, org_id){
	ajaxCall("${def:actionroot}/deletemember?memberid="+tuid+"&org_id="+org_id,{
		method:"get",
		dataType:"script",
		success:function(){
		}
	});
}

