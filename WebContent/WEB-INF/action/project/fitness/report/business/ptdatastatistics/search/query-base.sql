select
	tuid,
	results_money,
	task_money,
	concat(completion::numeric(18,2), '%') as completion,
	market_class_num,
	pt_inventory_num,
	pt_teaching_num,
	site_target_num,
	site_target_deal_num,
	concat(site_target_deal_rate::numeric(18,2), '%') as site_target_deal_rate,
	pt_expire_num,
	pt_renewal_num,
	concat(pt_renewal_rate::numeric(18,2), '%') as pt_renewal_rate,
	(select name from hr_staff where userlogin = cc_pt_data_statistics.userlogin) as name
from cc_pt_data_statistics
where org_id = ${def:org}

${filter}
${orderby}