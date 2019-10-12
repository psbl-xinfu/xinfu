select 
	td.code,
	td.train_part,
	td.apparatus,
	td.train_detail_part,
	td.groups,
	td.weight,
	td.num,
	td.custfeel,
	td.actions,
	td.actionscode
from cc_trainplan_detail td
where td.code = ${fld:code} and td.org_id = ${def:org}
order by td.created asc

