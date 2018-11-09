select
	pd.ptlevelname,
	pl.created,
	pl.leftcount::integer
from cc_ptlog pl
left join cc_ptdef pd on pl.ptlevelcode = pd.code and pl.org_id = pd.org_id
where pl.org_id = ${def:org} and pl.customercode = ${fld:customercode}
and pl.status = 1
