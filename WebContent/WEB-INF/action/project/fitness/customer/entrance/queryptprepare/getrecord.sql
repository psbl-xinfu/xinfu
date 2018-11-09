select
	concat('<input type="radio" class="ptpcode" name="ptpcode" value="', ptp.code, '" code="', pr.code, '">') as application_id,
	pd.ptlevelname,
	(select name from hr_staff where userlogin = ptp.ptid) as staff_name,
	pr.ptleftcount::int,
	(ptp.preparedate||' '||ptp.preparetime)::timestamp as preparedate,
	(select name from hr_staff where userlogin = ptp.createdby) as createdby
from cc_ptprepare ptp
left join cc_ptrest pr on ptp.ptrestcode = pr.code and ptp.org_id = pr.org_id
left join cc_ptdef pd on pr.ptlevelcode = pd.code and pr.org_id = pd.org_id
where
	ptp.org_id = ${fld:unionorgid} and ptp.customercode = ${fld:customercode}
	and ptp.status=1 and ptp.preparedate = '${def:date}'::date
order by ptp.preparedate asc,ptp.preparetime asc
