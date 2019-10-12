
$("#sitedefhour").html("${fld:sitedefhour}");
$("#sitedeflist").html("${fld:sitedeflist}");
$("#titlestr").html("${fld:titlestr}");
$("#minhour").val("${fld:minhour}");
$("#maxhour").val("${fld:maxhour}");
var mydate = new Date();
mydate.getHours();
var wc=(mydate.getHours()-8)*100+130
console.log((mydate.getHours()-8)*100+130)

$("#scroll").scrollLeft(wc);
console.log($("#scroll").scrollLeft());


//鼠标hover效果
$('#scroll>.prices').remove();
$('#scroll>.yi_bj').remove();
$('#scroll>.tc_yy').remove();

// 鼠标hover效果
$('.tc_yy').hide();
$(".cdlx_list tbody td").hover(function () {
   if ($(this).hasClass('gzb') == false) {
 	  $(this).find('.prices').hide()
       $(this).find('.tc_yy').show();
       // 场地预定
       $(".sheding").unbind().on("click", function () {
 		  $("#site_timelimitcode").val($(this).attr("site_timelimitcode"));
     	  querysitedefbycode($(this).parent().parent().attr("code"));
           $('.cd_zt').css('display', 'block');
       });
       // 调场
       $(".huanchang").unbind().on("click", function () {
     		ajaxCall("${def:actionroot}/querysiteusedetailcode?code="+$(this).attr("code")
     				+"&times="+$(this).attr("time")+":00:00&prepare_date="+$("#monitor").find(".now").attr("code"),{
     			method:"get",
     			dataType:"script",
     			success:function(){
     			}
     		});
           $('.cd_tc').css('display', 'block');
       });
   } else {
      $('.tc_yy').hide();
      $(this).append("<div class='tc_yy'><span class='sheding'></span></div>");
     // 场地预定
      $(".sheding").unbind().on("click", function () {
     	 $("#site_timelimitcode").val($(this).attr("site_timelimitcode"));
 		  querysitedefbycode($(this).parent().parent().attr("code"));
	       	  $('.cd_zt').css('display', 'block');
     });
   }
}, function () {
   $('.prices').show();
   $('.tc_yy').hide();
   if ($(this).hasClass('gzb') == false) {
       $(this).find('.prices').show();
   } else {
       $(this).empty();
   }
   if ($(this).find('.icheckbox_square-blue').hasClass("checked") == true) {
       $(this).find('.yi_bj').show();
   } else {
       $(this).find('.yi_bj').hide();
   }
});
ccms.util.renderCheckbox("sitedecode");

function querysitedefbycode(code){
	$("#sitekxdate").html("");
	//查询场地信息
	ajaxCall("${def:actionroot}/querysitedefbycode?code="+code+"&site_timelimitcode="+$("#site_timelimitcode").val(),{
		method:"get",
		dataType:"script",
		success:function(){
		}
	});
}
/*
$("#sitedeflist").html("");
//最小开场时间
var minhour = parseInt("${fld:minhour}");
//最大闭场时间
var maxhour = parseInt("${fld:maxhour}");
$("#minhour").val(minhour);
$("#maxhour").val(maxhour);

var sitedefhour = "<td width='130' nowrap></th>";
for(var i=minhour;i<=maxhour;i++){
	sitedefhour+="<td width='100' nowrap>"+i+":00</td>";
}
$("#sitedefhour").html(sitedefhour);
var titlestr = "<li>场地类型</li>";
<sitedef-rows>
titlestr+="<li>${fld:sitename@js}</li>";
	var sitedeflist ="<tr class='yysitetr' code='${fld:code}'><th></th>";<th>${fld:sitename@js}</th>
	for(var j=minhour;j<=maxhour;j++){
		var color = "gzb", pricesstr = "", choose_way="", str = "", price = "", szstr = "", site_timelimitcode = "";
		//查询包场
		ajaxCall("${def:actionroot}/querychooseway?sitecode=${fld:code}&limittime="+j+"&times="+j+":00:00"
				+"&prepare_date=${fld:prepare_date}",{
			method:"get",
			dataType:"json",
			async:false,
			success:function(data){
				choose_way = data.choose_way;
				//场地时段定义表code
				site_timelimitcode = data.site_timelimitcode;
				if(choose_way=="1"){
					//包场
					color = "canyb";
					pricesstr = "${fld:block_maxnum}人 ${fld:block_price}元";
					str="（包）${fld:sitename}-${fld:prepare_date}-"+j+":00";
					price="${fld:block_price}";
				}else if(choose_way=="2"){
					//拼场
					color = "yellowb";
					pricesstr = "${fld:group_minnum}/${fld:group_maxnum}人 ${fld:group_price}元";
					str="（拼）${fld:sitename}-${fld:prepare_date}-"+j+":00";
					price="${fld:group_price}";
				}
				//查询是否已预约
				if(choose_way.length>0){
					var sdnum = data.sdnum;
					if(choose_way=="1"&&sdnum>0){
						color="greyb";
						szstr="1";
					}else if(choose_way=="2"&&sdnum>=parseInt("${fld:group_maxnum}")){
						color="zongseb";
						szstr="1";
					}
				}
			}
		});
		
		sitedeflist+="<td class='"+color+"' code='${fld:code}'><div class='prices'>"+pricesstr+"</div>"
				+"<span style='display:none;' class='yi_bj'></span><div class='tc_yy'>";
		//已预约不显示CheckBox和设置
		if(szstr!="1"){
			sitedeflist+="<input type='checkbox' name='sitedecode' value='"+j+"' code='${fld:code}' codestr='"+str+"'"
            +" codestatus='"+choose_way+"' codeprice='"+price+"' class='kkk' style='margin-top:-3px;'>"
            +"<span class='sheding' site_timelimitcode='"+site_timelimitcode+"'></span>";
		}else{
			sitedeflist+="<span class='huanchang' code='${fld:code}' time='"+j+"'></span>";
		}
		sitedeflist+="</div></td>";
	}
	sitedeflist+="</tr>";
	$("#sitedeflist").append(sitedeflist);
</sitedef-rows>

$("#titlestr").html(titlestr);
// 鼠标hover效果
$('#scroll>.prices').remove();
$('#scroll>.yi_bj').remove();
$('#scroll>.tc_yy').remove();

  // 鼠标hover效果
  $('.tc_yy').hide();
  $(".cdlx_list tbody td").hover(function () {
      if ($(this).hasClass('gzb') == false) {
    	  $(this).find('.prices').hide()
          $(this).find('.tc_yy').show();
          // 场地预定
          $(".sheding").unbind().on("click", function () {
    		  $("#site_timelimitcode").val($(this).attr("site_timelimitcode"));
        	  querysitedefbycode($(this).parent().parent().attr("code"));
              $('.cd_zt').css('display', 'block');
          });
          // 调场
          $(".huanchang").unbind().on("click", function () {
        		ajaxCall("${def:actionroot}/querysiteusedetailcode?code="+$(this).attr("code")
        				+"&times="+$(this).attr("time")+":00:00&prepare_date="+$("#monitor").find(".now").attr("code"),{
        			method:"get",
        			dataType:"script",
        			success:function(){
        			}
        		});
              $('.cd_tc').css('display', 'block');
          });
      } else {
         $('.tc_yy').hide();
         $(this).append("<div class='tc_yy'><span class='sheding'></span></div>");
        // 场地预定
         $(".sheding").unbind().on("click", function () {
        	 $("#site_timelimitcode").val($(this).attr("site_timelimitcode"));
    		  querysitedefbycode($(this).parent().parent().attr("code"));
	       	  $('.cd_zt').css('display', 'block');
        });
      }
  }, function () {
      $('.prices').show();
      $('.tc_yy').hide();
      if ($(this).hasClass('gzb') == false) {
          $(this).find('.prices').show();
      } else {
          $(this).empty();
      }
      if ($(this).find('.icheckbox_square-blue').hasClass("checked") == true) {
          $(this).find('.yi_bj').show();
      } else {
          $(this).find('.yi_bj').hide();
      }
  });
ccms.util.renderCheckbox("sitedecode");

function querysitedefbycode(code){
	$("#sitekxdate").html("");
	//查询场地信息
	ajaxCall("${def:actionroot}/querysitedefbycode?code="+code+"&site_timelimitcode="+$("#site_timelimitcode").val(),{
		method:"get",
		dataType:"script",
		success:function(){
		}
	});
}


*/