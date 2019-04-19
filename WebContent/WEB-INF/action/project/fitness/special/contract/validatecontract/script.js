var total = "${fld:total}";
if( parseInt(total) > 0 ){
	ccms.dialog.notice("当前合同已产生关联合同，不允许再更改");
}else{
	if( "1" == "${fld:vc_type}" ){	// 修改已收款合同
		/**if( parseInt("${fld:i_stage_times}") > 1 ){
			ccms.dialog.notice("分期付款合同不允许修改费用");
		}else */if( "${fld:i_type}" == "4" ){
			ccms.dialog.notice("退卡合同不允许修改费用");
		}else{
			var url = '${def:context}${def:actionroot}/updatefee/crud?vc_code=${fld:vc_code@js}';
			ccms.dialog.open({url:url, id:"dialogPick", width:900, height:600});
		}
	}else if( "2" == "${fld:vc_type}" ){	// 删除已收款合同
		if( parseInt("${fld:i_stage_times}") > 1 ){
			ccms.dialog.notice("已付款分期付款合同不允许删除");
		/**}else if( "还款合同" == "${fld:vc_contractttype}" && "0" == "${fld:stage_times_pay_last}" ){
			ccms.dialog.notice("当前分期付款合同存在关联合同，不允许删除");*/
		}else{
			$Dialog().confirm("确定要删除已收款合同${fld:vc_code}吗?", function(){
				// 根据不同合同获取删除路径
				var uri = "";
				if( "升级合同" == "${fld:vc_contractttype}"){	// 升级合同
					//ccms.dialog.notice("当前合同不允许删除！");
					uri = "${def:context}${def:actionroot}/delete/upgrade?vc_code=${fld:vc_code}&card_code=${fld:card_code}";
				}else if( "还款合同" == "${fld:vc_contractttype}"){	// 还款合同
					uri = "${def:context}${def:actionroot}/delete/repayment?vc_code=${fld:vc_code}";
				}else if( "办卡合同" == "${fld:vc_contractttype}"){	// 办卡合同
					uri = "${def:context}${def:actionroot}/delete/setcard?vc_code=${fld:vc_code}";
				}else if( "续卡合同" == "${fld:vc_contractttype}"){	// 续卡合同
					uri = "${def:context}${def:actionroot}/delete/cttncard?vc_code=${fld:vc_code}";
				}else if( "转卡合同" == "${fld:vc_contractttype}"){	// 转卡合同
					uri = "${def:context}${def:actionroot}/delete/turncard?vc_code=${fld:vc_code}";
				}else if( "租柜合同" == "${fld:vc_contractttype}"){	// 租柜合同
					uri = "${def:context}${def:actionroot}/delete/cab?vc_code=${fld:vc_code}";
				}else if( "续租柜合同" == "${fld:vc_contractttype}"){	// 续租柜合同 --zzn好像删租柜合同走的是这个,目前没有续租柜合同
					uri = "${def:context}${def:actionroot}/delete/cttncab?vc_code=${fld:vc_code}";
				}else if( "私教合同" == "${fld:vc_contractttype}"){	// 私教合同
					uri = "${def:context}${def:actionroot}/delete/pt?vc_code=${fld:vc_code}";
				}else if( "退卡合同" == "${fld:vc_contractttype}"){	// 退卡合同
					uri = "${def:context}${def:actionroot}/delete/sendback?vc_code=${fld:vc_code}";
				}
				if( "" != uri){
					ajaxCall(uri,{
					   	method: "get",
					   	progress: true,
					   	dataType: "script",
					   	success: function() {
					   		ccms.dialog.notice("合同删除成功！",2000,function(){
					   			searchContract();
					   		});
					   	}
					});
				}
			});
		}
	}
}
