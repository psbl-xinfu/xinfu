 select
 	 concat('
	  <label class="am-checkbox">
	  <input type="checkbox"  data-am-ucheck name="datalist" 
	   value="',code,'','" >
	   </label>
	') as application_id,
 	campaign_name,
 	(case when validatetype=0 then '长期有效'  else '制定时间有效' end)  as validatetype,

 	(case when status=0 then '无效' when status=1 then '已启用'  else '未启用' end)  as status
 	
from cc_market_campaign 
where org_id=${def:org} and campaigntype=1
${filter}
${orderby}



