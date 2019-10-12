select 
	sum(con.normalmoney) as normalmoney
from cc_guest g 
inner join cc_guest_visit v on g.code = v.guestcode and v.status != 0 and g.org_id = v.org_id
left join cc_contract con on v.contractcode = con.code and v.org_id = con.org_id
where g.org_id = ${def:org} and g.org_id = ${def:org}
	and (v.visitdate >= ${fld:start_date} and v.visitdate <= ${fld:end_date})
	and con.contracttype !=3
	and con.status = 2
	and (case when ${fld:cust_all} is null then 1=1 else (g.name like concat('%', ${fld:cust_all}, '%') or g.mobile like concat('%', ${fld:cust_all}, '%')) end)