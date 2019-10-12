select 
	sud.code,
	sd.sitename,
	sud.prepare_date,
	sud.prepare_starttime,
	sud.prepare_endtime,
	(case when sud.customertype=0 then '资源'
		  when sud.customertype=1 then '会员' 
		  when sud.customertype=2 then '团队' 
		  when sud.customertype=3 then '散客' 
	end) as customertype,
	(case when cust.name is not null then cust.name when guest.name is not null then guest.name else sud.customername end) as name,
	(case when cust.mobile is not null then cust.mobile when guest.mobile is not null then guest.mobile else sud.mobile end) as mobile
from cc_siteusedetail sud
left join cc_sitedef sd on sud.sitecode = sd.code and sud.org_id = sd.org_id
left join cc_customer cust on sud.customercode = cust.code and sud.org_id = cust.org_id
left join cc_guest guest on sud.customercode = guest.code and sud.org_id = guest.org_id
where sud.sitecode=${fld:code} and sud.status>0 and sud.org_id = ${def:org}
and sud.prepare_date = ${fld:prepare_date}::date
and ${fld:times}::time>=sud.prepare_starttime and ${fld:times}::time<sud.prepare_endtime  

