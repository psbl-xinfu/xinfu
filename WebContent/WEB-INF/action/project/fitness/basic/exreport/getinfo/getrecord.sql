select
	e.code,
 	m.campaign_name,
 	
 	 	 	 (case 	when e.expertype=0 then '时效卡'
 	 	 	 			when e.expertype=1 then '计次卡'
 	 	    else '私教免费课'  end)  as expertype,
 	
 	
 	 	 (case 	when m.personnum is null then '无限制'
 	 	 else    concat('一人领取',m.personnum,'张') end)  as personnum,
 	 	 
 	 	 (case 	when m.totalnum is null then '无限制'
 	 	 else concat(m.totalnum,'张') end)  as totalnum,
 	 	 
		 
 	 	 m.enddate-m.startdate as day,
		 m.startdate,
		 m.enddate
from cc_market_campaign m
left join cc_expercard  e on  e.market_campaign_code= m.code and  e.org_id=${def:org}
where m.code=${fld:code}
and m.org_id=${def:org}

