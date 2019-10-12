
var date = new Date();
for(var i =0;i<31;i++){
	var sitedefdatestr = "";
	/*<rows>
		price = "${fld:price}";
		hour = "${fld:limittime}";
		ajaxCall("${def:actionroot}/querysiteusedetail?sitecode=${fld:code}&limittime="
				+"${fld:limittime}:00:00&prepare_date="+date.format("yyyy-MM-dd")+"&prepare_type=${fld:choose_way}&org_id=${fld:org_id}",{
			method:"get",
			dataType:"json",
			async:false,
			success:function(data){
				var yynum = data.yynum;
				if("${fld:choose_way}"=="1"&&yynum<=0){
					if(parseInt("${fld:limittime}")<hour||hour==0){
						hour = "${fld:limittime}";
					}
					if(parseInt("${fld:price}")<price||price==0){
						price = "${fld:price}";
					}
				}else if("${fld:choose_way}"=="2"&&yynum<parseInt("${fld:group_maxnum}")){
					if(parseInt("${fld:limittime}")<hour||hour==0){
						hour = "${fld:limittime}";
					}
					if(parseInt("${fld:price}")<price||price==0){
						price = "${fld:price}";
					}
				}
			}
		});
	</rows>*/
	$("#sitedefdatestr").append("<div class='swiper-slide' onclick=\"sitedefyy('${fld:sitetype}', '"+date.format("yyyy-MM-dd")+"')\"><p class='slider_time'>"
			+date.format("MM-dd")+"("+getWeek(date.format("yyyy-MM-dd"))+")</p>"
            +"<p class='slidet_price'>${fld:price}元起订></p><p class='slider_on'>${fld:hour}开始预定</p></div>");
	date.setDate(date.getDate()+1);
	var w = 0
	$(".details_prepare_list").each(function () {
		w += parseInt($(this).width());
	})
	$(".details_prepare_list").width(w+10);
	$(".details_prepare_list").length;
	// alert($(".details_prepare_list").width(w+10))

}
var w=($(".details_prepare_list div").width()+10)*($(".details_prepare_list div").length)
$(".details_prepare_list").width(w+20);
console.log($(".details_prepare_list").width())

/**
 * 根据日期字符串获取星期几
 * @param dateString 日期字符串（如：2016-12-29），为空时为用户电脑当前日期
 * @returns {String}
 */
function getWeek(dateString){
    var dateArray = dateString.split("-");
    var date = new Date(dateArray[0], parseInt(dateArray[1] - 1), dateArray[2]);
    return "周" + "日一二三四五六".charAt(date.getDay());
};

//跳转预定
function sitedefyy(st, parpreparedate){
	location.href = "${def:context}/action/project/fitness/wx/site/siteselected/crud?sitetype="
		+st+"&parpreparedate="+parpreparedate+"&org_id=${fld:org_id}&weixin_userid=${fld:weixin_userid}";
}
