 select
 expercardcode,
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
 	
 	
 	(select name from cc_expercard e where e.code=cc_market_campaign.expercardcode  and e.org_id=${def:org})as name,
 	 	(select 
 	 		(case 
 	 			when expertype=0 then '时效卡'
 	 			when expertype=1 then '计次卡'
 	 			when expertype=2 then '私教免费'
 	 		end)
 	 	from cc_expercard e where e.code=cc_market_campaign.expercardcode  and e.org_id=${def:org})as expertype,
 	(case when validatetype=0 then '长期有效'  else '指定时间有效' end)  as validatetype,
 	
 	
 	(case when status=0 then '无效' when status=1 then '已启用'  else '未启用' end)  as status,
 	
 	
 	(select count(1) from cc_expercard_log where market_campaign_code=cc_market_campaign.code) as lingnum,
 	
 	(
		select count(1) from cc_inleft  lef
				left join cc_expercard_list list on   lef.cardcode=list.code	and  list.org_id=${def:org}
				where  list.market_campaign_code=cc_market_campaign.code and	lef.org_id=${def:org}
	)as usenum
 	--活动转化率
from cc_market_campaign 
where org_id=${def:org} and campaigntype=0
${filter}
${orderby}



