 select
	 code,
 	 	concat('
	  <label class="am-checkbox">
	  <input type="checkbox"  data-am-ucheck name="datalist" 
	   value="',code,'','" 
		code="',status,'','" 
		expercardcode="',expercardcode,'','" 
		>
	   </label>
	') as application_id,
 	campaign_name,
 	
 	(case when votetype=0 then '每日均可投票'  else '一次性投票' end)  as votetype,
 	(case when totalnum is null then '不限'  else totalnum::varchar end)  as totalnum,
 	(case when status=0 then '无效' when status=1 then '已启用'  else '未启用' end)  as status
 	
 	
 	--活动转化率
from cc_market_campaign 
where org_id=${def:org} and campaigntype=3
${filter}
${orderby}



