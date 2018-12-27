UPDATE cc_siteusedetail 
SET status=0,
	remark=concat(remark, '，系统提示：该预约已超过系统预约时间，自动取消！')
where prepare_date+prepare_starttime+ INTERVAL ${fld:sitedate_value} <= '${def:timestamp}'::timestamp 
and paystatus=0 and status!=2
and org_id=${fld:org_id}
