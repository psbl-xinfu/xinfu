 select
 	 	concat('
	  <label class="am-checkbox">
	  <input type="checkbox"  data-am-ucheck name="datalist" 
	   value="',code,'','" >
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
 	(case when validatetype=0 then '长期有效'  else '制定时间有效' end)  as validatetype,
 	
 	(select count(*) from cc_card d 
 	left join cc_cardtype t on t.code=d.cardtype and t.type=3 and t.org_id=${def:org} 
 	where d.expercardcode=cc_market_campaign.expercardcode and d.org_id=${def:org} and isgoon=0 and d.status=1
 	) as num,
 	
 	(select  DISTINCT count(*) from cc_card d 
 	left join cc_cardtype t on t.code=d.cardtype and t.type=3 and t.org_id=${def:org} 
 	left join cc_inleft f on f.cardcode=d.code  and f.org_id=${def:org} 
 	where d.expercardcode=cc_market_campaign.expercardcode and d.org_id=${def:org} and isgoon=0 and d.status=1
 	) as usenum,
 	
 	(case when status=0 then '无效' when status=1 then '已启用'  else '未启用' end)  as status
 	--活动转化率
from cc_market_campaign 
where org_id=${def:org}
and campaigntype=0
${filter}
${orderby}



