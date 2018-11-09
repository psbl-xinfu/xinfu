select 
	count(DISTINCT(c.customercode)) as statusc
from cc_contract c 
inner join cc_customer m on m.code=c.customercode and c.org_id = m.org_id
inner join cc_guest g on g.code=m.guestcode and g.org_id = m.org_id
inner join cc_guest_visit gv on gv.guestcode = g.code and gv.org_id = g.org_id
where c.org_id = ${def:org} and c.createdate >= ${fld:start_date} and c.createdate <= ${fld:end_date} 
and (case when ${fld:cust_all} is null then 1=1 else (m.name like concat('%', ${fld:cust_all}, '%') or m.mobile like concat('%', ${fld:cust_all}, '%')) end)
and c.contracttype !=3 and c.type=0 and c.org_id = ${def:org} 
and m.status != 0 
and c.status = 2

