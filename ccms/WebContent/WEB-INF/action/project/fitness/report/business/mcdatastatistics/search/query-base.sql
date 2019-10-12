select
	tuid,
	results_money,
	task_money,
	strange_reception_num,
	strange_deal_num,
	appointment_visit_num,
	appointment_deal_num,
	cust_expire_num,
	cust_renewal_num,
	(select name from hr_staff where userlogin = cc_mc_data_statistics.userlogin) as name,
	concat(completion::numeric(18,2), '%') as completion,
	concat(strange_transaction_rate::numeric(18,2), '%') as strange_transaction_rate,
	concat(appointment_rate::numeric(18,2), '%') as appointment_rate,
	concat(mc_renewal_rate::numeric(18,2), '%') as mc_renewal_rate
from cc_mc_data_statistics
where org_id = ${def:org}

${filter}
${orderby}